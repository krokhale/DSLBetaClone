class LcontentsController < ApplicationController
 before_filter :authenticate, :only => [:edit,:update,:destroy]
  before_filter :setparam, :only => [:show]
  before_filter :getparam, :only => [:new,:show,:create,:update,:destroy,:import]
  after_filter  :setorder,:only => [:new]

  def index
    @title = "Lessons List"
    @lessons = Lesson.all
    
  end
  
  def show
     @lesson = Lcontent.find_by(:lid => params[:id])
     @title = @lesson.name
  end
  
  def edit
    @lesson = Lcontent.find_by(:lid => params[:id])
    @title= "Edit Lesson"
  end
  
  def update
     @lesson = Lcontent.find_by(:lid => params[:id])
    if @lesson.update_attributes(params[:lcontent])
       flash[:success]= "Lesson updated"
       redirect_to @coursemod
    else
       @title="Edit Lesson"
       flash.now[:error]="something went wrong"
       render 'edit'
    end
  end
  
  def create
    @lesson = Lcontent.new(params[:lcontent])
    @les = Lesson.new(:name => params[:lcontent][:name])
    get_validation_names=params[:sol_validations].split(',')
    mesg_hash={}
    get_validation_names.each do |name|
      if params[name.to_sym]
        mesg_hash[name] =  params[name.to_sym]
      end
    end
    @lesson.messages = mesg_hash
    if @les.save
      #it is saved succesfully
      @lesson.lid = @les.id
      @lesson.save!
      order = params[:lesson_order].to_i != 0 ? params[:lesson_order] : session[:les_ord]
      @modularization = @coursemod.modularizations.create(:lesson_id => @les.id,:lesson_order=>order)
      if @modularization.save
        flash[:success] = "Lesson successfully created !"
        redirect_to @coursemod
      else
        flash.now[:error]= "module_lesson not saved"
        render :action => 'new'
      end
    else
       flash.now[:error]= "lesson not saved"
       render 'new'
    end
  end
  
  def new
    @title="Create Lesson"
    @lesson_order=1
    if modularization = Modularization.where(:module_id => @coursemod.id).first
       @lesson_order=modularization.lesson_order+1
    end
    @lesson= Lcontent.new
  end
  
  def destroy
    @lesson = Lcontent.find(:lid => params[:id])
    @les = Lesson.find(params[:id])
    @lesson.destroy
    @les.destroy
    redirect_to @coursemod, :notice => "Successfully destroyed lesson."
  end
  
  def import
    #Lesson.import(params[:file])
    file= params[:file]
    order = next_lesson_order
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header,spreadsheet.row(i)].transpose]
      parameters = row.to_hash 
      mesg_str = parameters.delete("messages")
      mesg_arr = mesg_str.split("|")
      mesg_hash = {}
      mesg_arr.each do |m|
        h = m.split(":")
        unless h[1].empty?
          mesg_hash[h[0]]=h[1];
        end  
      end
      les_struct = Lesson.create!(:name => parameters["name"])
      lesson = Lcontent.new(parameters)
      if les_struct
        lesson.lid = les_struct.id
        lesson.messages = mesg_hash
        lesson.save
        modularization = @coursemod.modularizations.create(:lesson_id => les_struct.id,:lesson_order=>order)
        if modularization.save
                 
        else
          to_del = Lesson.find(lesson.id)
          to_del.destroy
          to_del = Lcontent.find_by(:lid => lesson.lid)
          to_del.destroy
        end
      end
    end 
      redirect_to @coursemod, :notice => "Successfully uploaded lessons"
  end
  
   private
   
     def next_lesson_order 
       order=1
       if modularization = Modularization.where(:module_id => @coursemod.id).first
         order=modularization.lesson_order+1
       end
       return order
     end
     
    def open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
     end
    end
  
    def setorder
       session[:les_ord]= @lesson_order
    end
    
    def getparam
      
      if session[:mid]
        @coursemod = Coursemod.find(session[:mid]) 
      else
        lesson = Lesson.find(params[:id])
        @coursemod = Coursemod.find(lesson.modularizations.first.module_id)
      end  
    end
    
    def setparam
      session[:lid] = params[:id]
    end
     
end

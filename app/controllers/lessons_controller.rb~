class LessonsController < ApplicationController

  before_filter :authenticate, :only => [:edit,:update,:destroy]
  before_filter :setparam, :only => [:show]
  before_filter :getparam, :only => [:new,:show,:create,:update,:destroy,:import]
  after_filter  :setorder,:only => [:new]

  def index
    @title = "Lessons List"
    @lessons = Lesson.all
    
  end
  
  def show
     @lesson = Lesson.find(params[:id])
     @title = @lesson.name
  end
  
  def edit
    @lesson = Lesson.find(params[:id])
    @title= "Edit Lesson"
  end
  
  def update
     @lesson = Lesson.find(params[:id])
    if @lesson.update_attributes(params[:lesson])
       flash[:success]= "Lesson updated"
       redirect_to @coursemod
    else
       @title="Edit Lesson"
       flash.now[:error]="something went wrong"
       render 'edit'
    end
  end
  
  def create
    @lesson = Lesson.new(params[:lesson])
    get_validation_names=params[:sol_validations].split(',')
    mesg_hash={}
    get_validation_names.each do |name|
      if params[name.to_sym]
        mesg_hash[name] =  params[name.to_sym]
      end
    end
    @lesson.messages = mesg_hash
    if @lesson.save
      #it is saved succesfully
      order = params[:lesson_order].to_i != 0 ? params[:lesson_order] : session[:les_ord]
      @modularization = @coursemod.modularizations.create(:lesson_id => @lesson.id,:lesson_order=>order)
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
    @lesson= Lesson.new
  end
  
  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
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
      lesson = Lesson.create! parameters
      if lesson
        lesson.messages = mesg_hash
        lesson.save
        modularization = @coursemod.modularizations.create(:lesson_id => lesson.id,:lesson_order=>order)
        if modularization.save
                 
        else
          to_del = Lesson.find(lesson.id)
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
        @lesson = Lesson.find(params[:id])
        @coursemod = Coursemod.find(@lesson.modularizations.first.module_id)
      end  
    end
    
    def setparam
      session[:lid] = params[:id]
    end
     
end

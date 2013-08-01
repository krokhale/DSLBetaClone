class LessonsController < ApplicationController

  before_filter :authenticate, :only => [:edit,:update,:destroy]
  before_filter :setparam, :only => [:show]
  before_filter :getparam, :only => [:new,:show,:create,:update,:destroy]
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
  
   private
  
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

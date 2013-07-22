class LessonsController < ApplicationController

  before_filter :authenticate, :only => [:edit,:update,:destroy]
  before_filter :setparam, :only => [:new]
  before_filter :getparam, :only => [:create,:update,:destroy,:show]

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
    if @lesson.save
      #it is saved succesfully
      @module_lesson = @coursemod.module_lessons.create(:lesson_id => @lesson.id)
      if @module_lesson.save
        flash[:success] = "Lesson successfully created !"
        redirect_to @coursemod
      else
        flash.now[:error]= "module_lesson not saved"
        redirect :sction => 'new'
      end
    else
       flash.now[:error]= "lesson not saved"
       render 'new'
    end
  end
  
  def new
    @title="Create Lesson"
    @lesson= Lesson.new
  end
  
  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    redirect_to @coursemod, :notice => "Successfully destroyed lesson."
  end
  
   private
  
    def getparam
      @coursemod = Coursemod.find(session[:mid]) 
    end
    
    def setparam
      session[:mid] = params[:mid]
    end 
  
  
end

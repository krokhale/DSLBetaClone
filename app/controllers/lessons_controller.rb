class LessonsController < ApplicationController


  def index
    @title = "Lessons List"
    @lessons = Lesson.all
    
  end
  
  def create
    @lesson = Lesson.new(params[:lesson])
     if @lesson.save
     #it is saved succesfully
     flash[:success] = "Lesson successfully created !"
     redirect_to lessons_path
    else
      @title= "Create Lesson"
      render 'new'
    end
  end
  
  def new
    @title="Create Lesson"
    @lesson= Lesson.new
  end
end
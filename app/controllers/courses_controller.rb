class CoursesController < ApplicationController

before_filter :authenticate, :only => [:index,:edit,:update,:destroy]
before_filter :setparam, :only => [:show]

#before_filter :correct_user, :only => [:edit, :update]

def home
    @title = "Course Manager"
    @courses = current_user.user_courses.paginate(:page => params[:page], :per_page => 5) # this list can be paginate
end

def index
    @title = "Courses"
    @courses = Course.paginate(:page => params[:page], :per_page => 5) # this list can be paginated
end 
  # editing the course content
 def edit
   @course= Course.find(params[:id])
   @title= "Edit Course"
 end 
 
 #updating the edited content
 def update
   @course = Course.find(params[:id])
   if @course.update_attributes(params[:course])
      flash[:success]= "course updated"
      redirect_to courses_path
   else
      @title="Edit Course"
      flash.now[:error]="something went wrong"
      render 'edit'
   end
 end
 # method to go to the course page
 def show
   @course = Course.find(params[:id])
   @modules = @course.coursemods.paginate(:page => params[:page])
   @title = @course.course_name;
 end
 
 def new
    @title = "New Course"
    @course= Course.new
  end

  def create
    @course = Course.new(params[:course]) 
    if @course.save
       @coursecreation = current_user.coursecreations.create(:role=>"o",:course_id=>@course.id)#role is yet to be coded for collaborators
       if @coursecreation.save
         flash[:notice]= "Successfully created coursecreation."
         redirect_to @course
       else
         flash.now[:error] = "course creation not saved"
         render :action => 'new'
       end
    else
      flash.now[:error] = "Course is not saved"
      render :action => 'new'
    end
 end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to root_url, :notice => "Successfully destroyed coursecreation."
  end
  
  private
  
     def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
     end
     
     def setparam
      session[:cid] = params[:id]
    end
end

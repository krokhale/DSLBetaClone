class CoursemodsController < ApplicationController

  before_filter :setparam, :only => [:new]
  before_filter :getparam, :only => [:create,:update,:destroy,:show]
  
  # editing the module content
  def edit
   @coursemod= Coursemod.find(params[:id])
   @title= "Edit Module"
  end 
 
  #updating the edited content
  def update
    @coursemod = Coursemod.find(params[:id])
    if @coursemod.update_attributes(params[:coursemod])
       flash[:success]= "Module updated"
       redirect_to @course
    else
       @title="Edit module"
       flash.now[:error]="something went wrong"
       render 'edit'
    end
  end
  # method to go to the module page
  def show
    @coursemod = Coursemod.find(params[:id])
    @lessons = @coursemod.lessons.paginate(:page => params[:page])
    @title = @coursemod.module_name
  end
 
 # method to render a new form for creating module
  def new
    #= Course.find(params[:cid])
     @title = "New Module"
     @coursemod= Coursemod.new
  end

  def create
    @coursemod = @course.coursemods.build(params[:coursemod]) 
    if @coursemod.save
      flash[:success]= "Successfully created a module"
      redirect_to @coursemod
    else
      flash.now[:error] = "module not saved"
      render :action => 'new'
    end
  end

  def destroy
    @coursemod = Coursemod.find(params[:id])
    @coursemod.destroy
    redirect_to @course, :notice => "Successfully destroyed coursecreation."
  end
  
  private
  
    def getparam
      @course = Course.find(session[:cid]) 
    end
    
    def setparam
      session[:cid] = params[:cid]
    end
 end

class UsersController < ApplicationController

  before_filter :authenticate, :only => [:index,:edit,:update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy 
  
  def index
    @title = "All Users"
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #it is saved succesfully
      @user.send_confirmation
      flash[:success] = "An activation link has been sent to your email.PLease activate your account"
      redirect_to root_path
    else
      @title= "Sign Up!"
      render 'new'
    end
     
  end
  
  def edit
    #@user = User.find(params[:id])
    @title = "Edit User"
  end
  
  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
     #it is can be updted succesfully
     flash[:success] = "Profile updated"
     redirect_to @user
    else
      @title= "Edit User"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to  users_path
  end
  
  def new
    @title = "Sign up!"
    @user= User.new
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name;
  end
  
  private 
   
      def admin_user
        redirect_to(root_path) unless current_user.admin?
      end 
      
     def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
      end
 
end

class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    if @user.save
     #it is saved succesfully
     sign_in @user
     flash[:success] = "Welcome to Sample App !"
     redirect_to @user
    else
      @title= "Sign Up!"
      render 'new'
    end
     
  end
  def new
    @title = "Sign up!"
    @user= User.new
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name;
  end
  
end

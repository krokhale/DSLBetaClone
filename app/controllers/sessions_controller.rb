class SessionsController < ApplicationController

  def create
    user= User.authenticate(params[:session][:email],params[:session][:password])
    if user.nil?
      #error mesage and re-render sign in form
      flash.now[:error]= "Invalid email/password combination"
      @title = "Sign in"
      render 'new' 
    else
      #sign in the user and open the show page of the user
      sign_in user
      redirect_to user
    end
  end
  
  def new
    @title = "Sign In"
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
end

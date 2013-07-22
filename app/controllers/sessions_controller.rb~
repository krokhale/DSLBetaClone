class SessionsController < ApplicationController

  def create
    user= User.authenticate(params[:session][:email],params[:session][:password])
    if user.nil?
      #error mesage and re-render sign in form
      flash.now[:error]= "Invalid email/password combination"
      @title = "Sign in"
      render 'new' 
    else
      if user.confirmed == true
        #sign in the user and open the show page of the user
        session[:permissions] = Authorization.get_permissions(user)
        sign_in(user, params[:remember_me])
        redirect_back_or user
      else
        flash.now[:error]= "not confirmed yet"
        @title = "Sign in"
        render 'new'
      end
    end
  end
  
  def new
    @title = "Sign In"
    if params[:confirmation]
      flash.now[:success]= "Your account is activated.Please sign in!"
      @user = User.find_by_confirmation_token!(params[:confirmation]) 
      @user.confirm_user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
end

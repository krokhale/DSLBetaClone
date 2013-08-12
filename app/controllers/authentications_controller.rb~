class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def omnisetup
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      user = authentication.user
      #this is repeated in sessions and here
      session[:permissions] = Authorization.get_permissions(user)
      sign_in(user, params[:remember_me])
      redirect_back_or user
    elsif current_user      
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      if omniauth['info']['email']
        user_save_redirect(omniauth,omniauth['info']['email']) 
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_authentication_url
      end
    end
   end
  
  def create
    if session[:omniauth]
      omniauth = session[:omniauth]
      user_save_redirect(omniauth,params[:email])
    end 
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
  
  private
    def user_save_redirect(omniauth,email)
      user = User.new(:name => omniauth['info']['name'],:email => email,:role=>"c_creator")
      user.apply_omniauth(omniauth) 
      user.save!
        user = User.find_by_email(email)
        user.confirm_user
        flash[:success] = "Authentication successful."
         #this is repeated in sessions and here
        session[:permissions] = Authorization.get_permissions(user)
        sign_in(user, params[:remember_me])
        redirect_back_or current_user
    end


end

class UserMailer < ActionMailer::Base
  default from: "membership@dataskillslab.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.email_confirmation.subject
  #
  def email_confirmation(user)
    @user = user

    mail :to => @user.email, :subject => "Activation link"
  end
 

def password_reset(user)
  @user = user
  mail :to => user.email, :subject => "Password Reset"
end


end

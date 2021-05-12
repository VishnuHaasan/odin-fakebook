class UserMailer < ApplicationMailer
  default from: 'fakebook@gomail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to fakebook!")
  end
end

class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @greeting = 'Hi'
    @user = params[:user]
    @message = 'message'
    mail to: @user.email, subject: 'Bienvenue sur Mini-Keyz !'
  end
end

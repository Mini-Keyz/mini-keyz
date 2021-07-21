class SimulationMailer < ApplicationMailer
  def send_it_to_me
    @user = params[:user]
    mail to: @user.email, subject: 'Bienvenue sur Mini-Keyz !'
  end
end

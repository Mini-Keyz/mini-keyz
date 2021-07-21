class SimulationMailer < ApplicationMailer
  # The email that will be sent to the user if he wants to have the simulation by email
  def send_it_to_me
    @user = params[:user]
    mail to: @user.email, subject: 'Bienvenue sur Mini-Keyz !'
  end
end

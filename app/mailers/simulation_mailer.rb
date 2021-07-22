class SimulationMailer < ApplicationMailer
  # The email that will be sent to the user if he wants to have the simulation by email
  def send_it_to_me
    @user = params[:user]
    @simulation = params[:simulation]
    mail(
      to: email_address_with_name(@user.email, "#{@user.first_name} #{@user.last_name.upcase}"),
      subject: "Votre simulation pour le bien de #{@simulation.house_city}"
    )
  end
end

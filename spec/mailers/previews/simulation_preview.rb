# Preview all emails at http://localhost:3000/rails/mailers/simulation
class SimulationPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/simulation/send_it_to_me
  def send_it_to_me
    user = User.first
    SimulationMailer.with(user: user).send_it_to_me
  end
end

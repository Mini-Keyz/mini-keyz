# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user/welcome
  def welcome
    user = User.first
    UserMailer.with(user: user).welcome
  end
end

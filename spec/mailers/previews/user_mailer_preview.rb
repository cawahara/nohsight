# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
   def confirmation_email
      user = User.first
      user.confirmation_token = User.create_token
      UserMailer.confirmation_email(user)
   end
end

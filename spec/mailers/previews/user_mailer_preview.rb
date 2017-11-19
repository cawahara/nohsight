# frozen_string_literal: true

class UserMailerPreview < ActionMailer::Preview
   # http://localhost:3000/rails/mailers/user_mailer/confirmation_email.html
   def confirmation_email
      user = User.first
      user.confirmation_token = User.create_token
      UserMailer.confirmation_email(user)
   end

   # http://localhost:3000/rails/mailers/user_mailer/password_reset_email.html
   def password_reset_email
      user = User.first
      user.create_password_reset_token
      UserMailer.password_reset_email(user)
   end
end

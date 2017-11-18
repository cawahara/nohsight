# Preview all emails at http://localhost:3000/rails/mailers/feedback_mailer
class FeedbackMailerPreview < ActionMailer::Preview
   def feedback_email
      user = User.first
      FeedbackMailer.feedback_email(user.email, 'feedback comment')
   end
end

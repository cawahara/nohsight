# frozen_string_literal: true

class FeedbackMailer < ApplicationMailer

   def feedback_email(email, content)
      @content = content
      mail(to: 'tsolvalouy@gmail.com', from: email, subject: '【Noh Sight】ご意見、お問い合わせ')
   end
end

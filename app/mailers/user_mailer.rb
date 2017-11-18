# frozen_string_literal: true

class UserMailer < ApplicationMailer

   def confirmation_email(user)
      @user = user
      mail(to: @user.email, subject: '【Noh Sight】 本登録のご案内')
   end

   def password_reset_email(user)
      @user = user
      mail(to: @user.email, subject: '【Noh Sight】 パスワード再設定のご案内')
   end
end

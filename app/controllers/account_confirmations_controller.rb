# frozen_string_literal: true

class AccountConfirmationsController < ApplicationController

   def new
      @email = ''
   end

   def edit
      user = User.find_by(email: params[:email])
      if user && !user.confirmed? && user.authenticated?('confirmation', params[:token])
         user.update_attributes!(confirmed: true, confirmed_at: Time.zone.now)
         login(user)
         flash.delete(:info)
         flash[:success] = 'ユーザー登録が完了しました！NohSightへようこそ！'
         redirect_to user_url(user)
      else
         if user && user.confirmed?
            flash[:danger] = "メールアドレス「#{user.email}」はすでに登録完了されています"
         else
            flash[:danger] = "無効なリンクURLです"
         end
         redirect_to(root_url)
      end
   end

   def create
      @email = params[:confirmation][:email]
      user = User.find_by(email: @email)
      if user && !user.confirmed?
         user.create_activation_digest
         user.save
         flash['success'] = '本登録のご案内メールを送信しました。URLをクリックしてユーザー登録を完了してくださいしてください'
         UserMailer.confirmation_email(user).deliver
         redirect_to(root_url)
      elsif user && user.confirmed?
         flash[:danger] = "メールアドレス「#{user.email}」はすでに登録完了されています"
         redirect_to(root_url)
      else
         flash.now[:danger] = '入力情報に不備があります'
         render 'account_confirmations/new'
      end
   end
end

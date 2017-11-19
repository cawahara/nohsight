# frozen_string_literal: true

class PasswordResetsController < ApplicationController
   before_action :logout

   def new
   end

   def edit
      @user = User.find_by(email: params[:email])
      if @user && @user.confirmed? && @user.authenticated?('password_reset', params[:token])
         return
      else
         if @user.nil? || !@user.confirmed?
            flash[:danger] = "ユーザが登録されていない、または仮登録中です"
            redirect_to(root_url)
         else
            flash[:danger] = "無効なリンクURLです"
            redirect_to(root_url)
         end
      end
   end

   def create
      user = User.find_by(email: params[:reset][:email])
      if user && user.confirmed?
         user.create_password_reset_token
         flash['success'] = 'パスワード再設定のご案内メールを送信しました。URLをクリックしてパスワードの再設定を行ってください'
         UserMailer.password_reset_email(user).deliver
         redirect_to(root_url)
      else
         if user && !user.confirmed?
            flash.now[:danger] = 'ユーザが仮登録中です。本登録のEメールからユーザ登録を完了してください'
         else
            flash.now[:danger] = '入力情報に不備があります'
         end
         render 'password_resets/new'
      end
   end

   def update
      user = User.find_by(email: params[:reset][:email])
      if user && params[:reset][:password] == params[:reset][:password_confirmation]
         user.update_attributes(password: params[:reset][:password])
         flash[:success] = 'パスワードの設定が完了しました'
         login(user)
         flash.delete(:info)
         redirect_to(dashboard_url)
      else
         flash.now[:danger] = '入力情報に不備があります'
         render 'password_resets/edit'
      end
   end
end

# frozen_string_literal: true

class UsersController < ApplicationController
   before_action :set_user,     only: [:show, :edit, :update, :destroy]
   before_action :logged_in?,   only: [:edit, :update, :destroy]
   before_action :logged_user?, only: [:edit, :update, :destroy]

   def new
      @user = User.new
   end

   def show
      @events = public_events(@user.events).order(start_date: :desc).limit(3)
   end

   def edit
   end

   def create
      @user = User.new(user_params)
      if @user.save
         flash['success'] = '本登録のご案内メールを送信しました。URLをクリックしてユーザー登録を完了してくださいしてください'
         UserMailer.confirmation_email(@user).deliver
         redirect_to(root_url)
      else
         flash['danger'] = '入力情報に不備があります'
         render 'users/new'
      end
   end

   def update
      if @user.update_attributes(user_params)
         flash['success'] = 'ユーザー情報を更新しました'
         redirect_to(user_url(current_user))
      else
         flash['danger'] = '入力情報に不備があります'
         render 'users/edit'
      end
   end

   def destroy
      if @user.destroy
         flash['info'] = 'ユーザー情報を削除しました'
      else
         flash['danger'] = 'ユーザー情報を削除できません'
      end
      redirect_to(root_url)
   end

   private

   def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :information,
                                   :password,
                                   :password_confirmation,
                                   :agreement)
   end

   def set_user
      @user = User.find(params[:id])
   end
end

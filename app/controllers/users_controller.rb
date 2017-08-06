# frozen_string_literal: true

class UsersController < ApplicationController
   before_action :logged_in?,   only: [:edit, :update, :destroy]
   before_action :logged_user?, only: [:edit, :update, :destroy]

   def new
      @user = User.new
   end

   def show
      @user = User.find(params[:id])
      user_events = []
      @user.user_events.each do |user_event|
         user_events << user_event.event_id
      end
      @events = Event.where(id: user_events, published: true).limit(3)
   end

   def edit
      @user = User.find(params[:id])
   end

   def create
      @user = User.new(user_params)
      if @user.save
         flash['success'] = 'ユーザー登録が完了しました'
         login(@user)
         redirect_to(root_url)
      else
         flash['danger'] = '入力情報に不備があります'
         render 'users/new'
      end
   end

   def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
         flash['success'] = 'ユーザー情報を更新しました'
         redirect_to(user_url(current_user))
      else
         flash['danger'] = '入力情報に不備があります'
         render 'users/edit'
      end
   end

   def destroy
      @user = User.find(params[:id])
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
end

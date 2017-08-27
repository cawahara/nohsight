# frozen_string_literal: true

class SessionsController < ApplicationController
   before_action :logged_in?, only: [:destroy]

   def new
      current_user
      logout
   end

   def create
      user = User.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:password])
         flash['info'] = 'Noh-Event(仮)へようこそ！'
         login(user)
         redirect_to(dashboard_url)
      else
         flash['danger'] = '入力情報に不備があります'
         render 'sessions/new'
      end
   end

   def destroy
      logout
      redirect_to login_path
   end
end

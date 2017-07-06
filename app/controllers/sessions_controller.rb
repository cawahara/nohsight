class SessionsController < ApplicationController
   before_action :is_logged_in?, only: [:destroy]

  def new
     if is_logged?
        user = current_user
        logout
     end
  end

  def create
     user = User.find_by(email: params[:session][:email])
     if user && user.authenticate(params[:session][:password])
        flash['info'] = "Noh-Event(仮)へようこそ！"
        login(user)
        redirect_to(dashboard_url)
     else
        if !user
           flash['danger'] = "アカウントが登録されていません"
        else
           flash['danger'] = "入力情報に不備があります"
        end
        render 'sessions/new'
     end
  end

  def destroy
     logout
     redirect_to login_path
  end
end

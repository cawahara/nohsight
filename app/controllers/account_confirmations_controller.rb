class AccountConfirmationsController < ApplicationController

   def edit
      user = User.find_by(email: params[:email])
      if user && !user.confirmed? && user.authenticated?('confirmation', params[:token])
         user.update_attributes!(confirmed: true, confirmed_at: Time.zone.now)
         login(user)
         flash[:success] = 'ユーザー登録が完了しました！NohSightへようこそ！'
         redirect_to user_url(user)
      else
         if user && user.confirmed?
            flash[:danger] = "メールアドレス「#{user.email}」はすでに登録完了されています"
         else
            flash[:danger] = "無効なリンクURLです"
         end
         redirect_to root_url
      end
   end

   def new
   end

   def create
   end
end

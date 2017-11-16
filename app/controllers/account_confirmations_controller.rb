class AccountConfirmationsController < ApplicationController

   def new
      user = User.find_by(email: params[:email])
      if user && !user.confirmed? && user.authenticated?('confirmation', params[:token])
         user.update_attributes!(confirmed: true, confirmed_at: Time.zone.now)
         login(user)
         flash[:success] = 'ユーザー登録が完了しました！NohSightへようこそ！'
         redirect_to user_url(user)
      elsif user.nil? || !user.authenticated?('confirmation', params[:token])
         flash[:danger] = "無効なリンクURLです"
      elsif user.confirmed?
         flash[:danger] = "メールアドレス「#{user.email}」はすでに登録完了されています"
      end
      redirect_to new_user_url
   end
end

# frozen_string_literal: true

module SessionsHelper
   def current_user
      return unless session[:user_id]
      @current_user ||= User.find(session[:user_id])
   end

   def logged?
      return !current_user.nil?
   end

   def login(user)
      # TODO: session有効期間の設定
      if user.confirmed?
         flash.now['info'] = 'Noh Sightへようこそ！'
         session[:user_id] = user.id
      else
         flash.now[:danger] = '本登録が完了しておりません。ご案内のメールを確認し、添付されたURLをクリックしてください。'
      end
   end

   def logout
      session.delete(:user_id)
      @current_user = nil
   end

   def store_location
      session.delete(:forward_url)
      session[:forward_url] = request.original_url if request.get?
   end

   def redirect_back_or(default)
      redirect_to session[:forward_url] || default
      session.delete(:forward_url)
   end

   # TODO: cookie機能の実装
end

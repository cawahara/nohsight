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
      session[:user_id] = user.id
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

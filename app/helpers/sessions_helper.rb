module SessionsHelper

   def current_user
      if user_id = session[:user_id]
         @current_user || User.find_by(id: session['user_id'])
      end
   end

   def is_logged?
      return !current_user.nil?
   end

   def login(user)
      # TODO session有効期間の設定
      session[:user_id] = user.id
   end

   def logout
      session.delete(:user_id)
      @current_user = nil
   end
   # TODO cookie機能の実装
end

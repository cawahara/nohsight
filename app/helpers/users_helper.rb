# frozen_string_literal: true

module UsersHelper

   def admin_user?
      return current_user.is_admin?
   end
end

module SpecTesthelper
   def login_as(user)
      controller.session[:user_id] = user.id
   end
end

RSpec.configure do |config|
   config.include SpecTesthelper, type: :controller
end

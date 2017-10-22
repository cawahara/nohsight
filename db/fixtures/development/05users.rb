# frozen_string_literal: true

User.seed do |s|
   s.id              = 12
   s.name            = 'tester'
   s.email           = 'test@gmail.com'
   s.password_digest = User.digest('password')
   s.is_admin        = false
end

User.seed do |s|
   s.id              = 22
   s.name            = 'admin_tester'
   s.email           = 'admin@gmail.com'
   s.password_digest = User.digest('password')
   s.is_admin        = true
end

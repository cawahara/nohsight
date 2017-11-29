# frozen_string_literal: true

User.seed do |s|
   s.id              = 1
   s.name            = 'tester'
   s.email           = 'test@gmail.com'
   s.password_digest = User.digest('password')
   s.is_admin        = false
   s.confirmed       = true
   s.confirmed_at    = Time.zone.now
end

User.seed do |s|
   s.id              = 2
   s.name            = 'admin_tester'
   s.email           = 'admin@gmail.com'
   s.password_digest = User.digest('password')
   s.is_admin        = true
   s.confirmed       = true
   s.confirmed_at    = Time.zone.now
end

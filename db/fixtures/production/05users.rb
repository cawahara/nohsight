# frozen_string_literal: true

User.seed do |s|
   s.id              = 12
   s.name            = 'tester'
   s.email           = 'test@gmail.com'
   s.password_digest = User.digest('password')
end

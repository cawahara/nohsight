User.seed do |s|
   s.id              = 1
   s.name            = "例　学士"
   s.email           = "example@gmail.com"
   s.password_digest = User.digest('password')
end

User.seed do |s|
   s.id              = 2
   s.name            = "例　見習"
   s.email           = "pupil@gmail.com"
   s.password_digest = User.digest('password')
end

User.seed do |s|
   s.id              = 3
   s.name            = "例　師匠"
   s.email           = "master@gmail.com"
   s.password_digest = User.digest('password')
end

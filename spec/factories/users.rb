require 'factory_girl'

FactoryGirl.define do
  factory :model_user, class: User do
      name                  'Michael'
      email                 'michael@gmail.com'
      information           'Nice to be with you.'
      password              'password'
      password_confirmation 'password'
      agreement              true

      initialize_with { User.find_or_create_by(email: email) }
  end
end

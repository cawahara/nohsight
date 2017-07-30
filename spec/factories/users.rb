# frozen_string_literal: true

require 'factory_girl'

FactoryGirl.define do
   factory :model_user, class: User do
      name                  'Paul'
      email                 'paul@gmail.com'
      information           'Nice to be with you.'
      password              'password'
      password_confirmation 'password'
      agreement true

      initialize_with { User.find_or_create_by(email: email) }
   end

   factory :diff_user, class: User do
      name                  'Billy'
      email                 'billy@gmail.com'
      information           'Nice to be with you.'
      password              'password'
      password_confirmation 'password'
      agreement true

      initialize_with { User.find_or_create_by(email: email) }
   end

   factory :admin_user, class: User do
      name                  'Pat'
      email                 'pat@gmail.com'
      information           'Nice to be with you.'
      password              'password'
      password_confirmation 'password'
      agreement true

      initialize_with { User.find_or_create_by(email: email) }
   end
end

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

      trait :start_from_this do
         after(:create) do |user|
            FactoryGirl.create(:model_user_event, user: user)
         end
      end
   end

   factory :another_user, class: User do
      name                  'Billy'
      email                 'billy@gmail.com'
      information           'Nice to be with you.'
      password              'password'
      password_confirmation 'password'
      agreement true

      trait :start_from_this do
         after(:create) do |user|
            FactoryGirl.create(:another_user_event, user: user)
         end
      end
   end
=begin
   factory :admin_user, class: User do
      name                  'Pat'
      email                 'pat@gmail.com'
      information           'Nice to be with you.'
      password              'password'
      password_confirmation 'password'
      agreement true

      initialize_with { User.find_or_create_by(email: email) }
   end
=end
end

# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
   factory :model_user, class: User do
      name                  'Paul'
      email                 'paul@gmail.com'
      information           'Nice to be with you.'
      password              'password'
      password_confirmation 'password'
      agreement             true
      confirmed             true
      confirmed_at          Time.zone.now

      trait :start_from_this do
         after(:create) do |user|
            event = FactoryBot.create(:model_user_event, user: user).event
            FactoryBot.create_list :model_point_record, user.events.count, user: user
            FactoryBot.create(:model_comment, user: user, event: event)
            FactoryBot.create(:model_bookmark, user: user, event: event)
            FactoryBot.create(:model_join_history, user: user, event: event)
         end
      end
   end

   factory :another_user, class: User do
      name                  'Billy'
      email                 'billy@gmail.com'
      information           "I'm addicted to that rush"
      password              'password'
      password_confirmation 'password'
      is_admin              false
      agreement             true
      confirmed             true
      confirmed_at          Time.zone.now

      trait :start_from_this do
         after(:create) do |user|
            event = FactoryBot.create(:another_user_event, user: user).event
            FactoryBot.create_list :another_point_record, user.events.count, user: user
            FactoryBot.create(:another_comment, user: user, event: event)
            FactoryBot.create(:another_bookmark, user: user, event: event)
            FactoryBot.create(:another_join_history, event: event, user: user)
         end
      end
   end

   factory :controller_user, class: User do
      name                  'Pat'
      email                 'pat@gmail.com'
      information           'I would like to stay together'
      password              'password'
      password_confirmation 'password'
      is_admin              false
      agreement              '1'       # post時のagreementパラムの値
      confirmed             true
      confirmed_at          Time.zone.now

      trait :start_from_this do
         after(:create) do |user|
            FactoryBot.create(:controller_user_event, user: user)
         end
      end

      trait :invalid_params do
         name               nil
      end

      trait :not_agreed do
         agreement          '0'
      end

      trait :user_show_action do
         after(:create) do |user|
            # TODO: 関連イベントを5個分つくる(create_listでね)
            5.times do |n|
               FactoryBot.create(:controller_user_event, user: user)
            end
         end
      end
   end

   factory :different_user, class: User do
      name                  'Richie'
      email                 'richie@gmail.com'
      information           'What if I say loving you?'
      password              'password'
      password_confirmation 'password'
      is_admin              false
      agreement             true
      confirmed             true
      confirmed_at          Time.zone.now

      trait :start_from_this do
         after(:create) do |user|
            FactoryBot.create(:different_user_event, user: user)
         end
      end
   end

   factory :admin_user, class: User do
      name                  'Lena'
      email                 'lena@gmail.com'
      information           'They hurt me, too'
      password              'password'
      password_confirmation 'password'
      is_admin              true
      agreement             true
      confirmed             true
      confirmed_at          Time.zone.now
   end

   factory :search_user, class: User do
      name                  'Julia'
      email                 'julia@gmail.com'
      information           'All the things she said'
      password              'password'
      password_confirmation 'password'
      is_admin              false
      agreement             true
      confirmed             true
      confirmed_at          Time.zone.now

      after(:create) do |user|
         FactoryBot.create(:first_search_user_event, user: user)
         FactoryBot.create(:second_search_user_event, user: user)
         FactoryBot.create(:third_search_user_event, user: user)
         FactoryBot.create(:fourth_search_user_event, user: user)
         FactoryBot.create(:fifth_search_user_event, user: user)
         FactoryBot.create(:sixth_search_user_event, user: user)
      end
   end
end

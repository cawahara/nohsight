# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
   factory :model_performer, class: Performer do
      association :style, factory: :model_style

      full_name   '田中 幸弘'
      last_name   'たなか'
      first_name  'ゆきひろ'

      trait :start_from_this do
         after(:create) do |performer|
            FactoryBot.create(:model_event_performer, performer: performer)
         end
      end
   end

   factory :another_performer, class: Performer do
      association :style, factory: :another_style

      full_name   '松本 秀隆'
      last_name   'まつもと'
      first_name  'ひでたか'

      trait :start_from_this do
         after(:create) do |performer|
            FactoryBot.create(:another_event_performer, performer: performer)
         end
      end
   end

   factory :controller_performer, class: Performer do
      association :style, factory: :controller_style

      full_name   '宇津井　薫'
      last_name   'うつい'
      first_name  'かおる'

      trait :start_from_this do
         after(:create) do |performer|
            FactoryBot.create(:controller_event_performer, performer: performer)
         end
      end

      trait :invalid_params do
         full_name  nil
      end

      trait :performer_show_action do
         after(:create) do |performer|
            5.times do |n|
               FactoryBot.create(:controller_event_performer, performer: performer)
            end
         end
      end
   end

   factory :different_performer, class: Performer do
      association :style, factory: :different_style

      full_name   '望月 春樹'
      last_name   'もちづき'
      first_name  'はるき'

      trait :start_from_this do
         after(:create) do |performer|
            FactoryBot.create(:different_event_performer, performer: performer)
         end
      end
   end

   factory :first_search_performer, class: Performer do
      association :style, factory: :first_search_style

      full_name   '田中 勇気'
      last_name   'たなか'
      first_name  'ゆうき'
   end

   factory :second_search_performer, class: Performer do
      association :style, factory: :second_search_style

      full_name   '鈴木 まさし'
      last_name   'すずき'
      first_name  'まさし'
   end

   factory :third_search_performer, class: Performer do
      association :style, factory: :third_search_style

      full_name   '石川 権兵衛'
      last_name   'いしかわ'
      first_name  'ごんべえ'
   end
end

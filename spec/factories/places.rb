# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
   factory :model_place, class: Place do
      title        'Temple'
      address      'kyoto'
      official_url 'http://www.temple.com'

      trait :start_from_this do
         after(:create) do |place|
            FactoryBot.create(:model_event, place: place)
         end
      end
   end

   factory :another_place, class: Place do
      title        'Shrine'
      address      'shiga'
      official_url 'http://www.shrine.com'

      trait :start_from_this do
         after(:create) do |place|
            FactoryBot.create(:another_event, place: place)
         end
      end
   end

   factory :controller_place, class: Place do
      title        'Ruin'
      address      'Mie'
      official_url 'http://www.ruin@www.com'

      trait :start_from_this do
         after(:create) do |place|
            FactoryBot.create(:controller_event, place: place)
         end
      end

      trait :invalid_params do
         title  nil
      end

      trait :place_show_action do
         after(:create) do |place|
            5.times do |n|
               FactoryBot.create(:controller_event, place: place)
            end
         end
      end
   end

   factory :different_place, class: Place do
      title        'Ancient Place'
      address      'Oita'
      official_url 'http://www.ancient-place@com'

      trait :start_from_this do
         after(:create) do |place|
            FactoryBot.create(:different_event, place: place)
         end
      end
   end

   factory :first_search_place, class: Place do
      title        '能楽堂'
      address      '京都府'
      official_url 'http://www.nohgakudo@www.com'
   end

   factory :second_search_place, class: Place do
      title        '舞台センター'
      address      '大阪府'
      official_url 'http://www.butaicenter@www.com'
   end

   factory :third_search_place, class: Place do
      title        '某公民館'
      address      '奈良県'
      official_url 'http://www.bohkominkan@www.com'
   end
end

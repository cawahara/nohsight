require 'factory_girl'

FactoryGirl.define do
   factory :model_event, class: Event do
      association :place, factory: :model_place

      title          'First Event'
      start_date     Date.today
      information    'It will be the best event for you!'
      official_url   'http//www.firstevent.com'
      published      true

      open_date      Date.today - 1

      trait :start_from_this do
         after(:create) do |event|
            FactoryGirl.create(:model_event_program, event: event)
            FactoryGirl.create(:model_ticket, event: event)
            FactoryGirl.create(:model_user_event, event: event)
         end
      end
   end

   factory :another_event, class: Event do
      association :place, factory: :another_place

      title          'Another Event'
      start_date     Date.today
      information    'It will be the best event for you!'
      official_url   'http//www.anotherevent.com'
      published      true

      trait :start_from_this do
         after(:create) do |event|
            FactoryGirl.create(:another_event_program, event: event)
            FactoryGirl.create(:another_ticket, event: event)
            FactoryGirl.create(:another_user_event, event: event)
         end
      end
   end

   factory :controller_event, class: Event do
      association :place, factory: :controller_place

      title          'Controller Event'
      start_date     Date.today
      information    'It will be the best event for you!'
      official_url   'http//www.controllerevent.com'
      published      true

      open_date      Date.today - 1

      trait :invalid_params do
         title       nil
      end

      trait :start_from_this do
         after(:create) do |event|
            FactoryGirl.create(:controller_event_program, event: event)
            FactoryGirl.create(:controller_ticket, event: event)
            FactoryGirl.create(:controller_user_event, event: event)
         end
      end
   end

   factory :different_event, class: Event do
      association :place, factory: :different_place

      title          'Different Event'
      start_date     Date.today
      information    'It will be the best event for you!'
      official_url   'http//www.differentevent.com'
      published      true

      trait :start_from_this do
         after(:create) do |event|
            FactoryGirl.create(:different_event_program, event: event)
            FactoryGirl.create(:different_ticket, event: event)
            FactoryGirl.create(:different_user_event, event: event)
         end
      end
   end

   factory :first_search_event, class: Event do
      association :place, factory: :first_search_place

      title          '能楽堂公演その一'
      start_date     Date.today
      published      true

      after(:create) do |event|
         FactoryGirl.create(:first_search_event_program, event: event)
      end
   end

   factory :second_search_event, class: Event do
      association :place, factory: :first_search_place

      title          '能楽堂公演その二'
      start_date     Date.today
      published      true

      after(:create) do |event|
         FactoryGirl.create(:second_search_event_program, event: event)
      end
   end

   factory :third_search_event, class: Event do
      association :place, factory: :first_search_place

      title          '能楽堂公演その三'
      start_date     Date.today
      published      true

      after(:create) do |event|
         FactoryGirl.create(:third_search_event_program, event: event)
      end
   end

   factory :fourth_search_event, class: Event do
      association :place, factory: :second_search_place

      title          '舞台センター公演その一'
      start_date     Date.today
      published      true

      after(:create) do |event|
         FactoryGirl.create(:fourth_search_event_program, event: event)
      end
   end

   factory :fifth_search_event, class: Event do
      association :place, factory: :second_search_place

      title          '舞台センター公演その二'
      start_date     Date.today
      published      true

      after(:create) do |event|
         FactoryGirl.create(:fifth_search_event_program, event: event)
      end
   end

   factory :sixth_search_event, class: Event do
      association :place, factory: :third_search_place

      title          '某公民館公演その一'
      start_date     Date.today
      published      true

      after(:create) do |event|
         FactoryGirl.create(:sixth_search_event_program, event: event)
      end
   end
end

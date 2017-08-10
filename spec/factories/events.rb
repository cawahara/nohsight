require 'factory_girl'

FactoryGirl.define do
   factory :model_event, class: Event do
      association :place, factory: :model_place

      title          'First Event'
      start_date     Date.today
      information    'It will be the best event for you!'
      official_url   'http//www.firstevent.com'
      published      true

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
=begin
   factory :diff_event, class: Event do
      association :place, factory: :model_place

      title          'Different Event'
      start_date     Date.today
      information    'It will be the best event for you!'
      official_url   'http//www.differentevent.com'
      published      true

      initialize_with { Event.find_or_create_by(title: title) }
   end

   factory :admin_event, class: Event do
      association :place, factory: :admin_place

      title          'Admin Event'
      start_date     Date.today
      information    'It will be the best event for you!'
      official_url   'http//www.adminevent.com'
      published      true

      initialize_with { Event.find_or_create_by(title: title) }
   end
=end
end

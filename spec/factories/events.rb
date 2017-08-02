require 'factory_girl'

FactoryGirl.define do
   factory :model_event, class: Event do
      association :place, factory: :model_place

      title          'First Event'
      start_date     Date.today
      end_date       Date.today + 1
      information    'It will be the best event for you!'
      official_url   'http//www.firstevent.com'
      published      true

      initialize_with { Event.find_or_create_by(title: title) }
   end

   factory :diff_event, class: Event do
      association :place, factory: :model_place

      title          'Different Event'
      start_date     Date.today
      end_date       Date.today + 1
      information    'It will be the best event for you!'
      official_url   'http//www.differentevent.com'
      published      true

      initialize_with { Event.find_or_create_by(title: title) }
   end

   factory :admin_event, class: Event do
      association :place, factory: :admin_place

      title          'Admin Event'
      start_date     Date.today
      end_date       Date.today + 1
      information    'It will be the best event for you!'
      official_url   'http//www.adminevent.com'
      published      true

      initialize_with { Event.find_or_create_by(title: title) }
   end
end

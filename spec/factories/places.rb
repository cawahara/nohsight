require 'factory_girl'

FactoryGirl.define do
   factory :model_place, class: Place do
      title        'Temple'
      address      'kyoto'
      official_url 'http://www.temple.com'

      trait :start_from_this do
         after(:create) do |place|
            FactoryGirl.create(:model_event, place: place)
            FactoryGirl.create(:model_program, place: place)
         end
      end
   end

   factory :another_place, class: Place do
      title        'Shrine'
      address      'shiga'
      official_url 'http://www.shrine.com'

      trait :start_from_this do
         after(:create) do |place|
            FactoryGirl.create(:another_event, place: place)
            FactoryGirl.create(:another_program, place: place)
         end
      end
   end
=begin
   factory :alter_place, class: Place do
      title        'Al_tower'
      address      'kyoto'
      official_url 'http://www.al_tower.com'

      initialize_with { Place.find_or_create_by(title: title) }
   end

   factory :admin_place, class: Place do
      title        'Ad_shrine'
      address      'kyoto'
      official_url 'http://www.ad_shrine.com'

      initialize_with { Place.find_or_create_by(title: title) }
   end
=end
end

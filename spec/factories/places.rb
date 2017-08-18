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

   factory :controller_place, class: Place do
      title        'Ruin'
      address      'Mie'
      official_url 'http://www.ruin@www.com'

      trait :start_from_this do
         after(:create) do |place|
            FactoryGirl.create(:controller_event, place: place)
            FactoryGirl.create(:controller_program, place: place)
         end
      end
   end

   factory :different_place, class: Place do
      title        'Ancient Place'
      address      'Oita'
      official_url 'http://www.ancient-place@com'

      trait :start_from_this do
         after(:create) do |place|
            FactoryGirl.create(:different_event, place: place)
            FactoryGirl.create(:different_program, place: place)
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

   factory :search_program_place, class: Place do
      title        '五条大橋'
      address      '京都府'
      official_url 'http://www.gojohashi@www.com'
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

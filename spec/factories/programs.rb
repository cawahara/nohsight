require 'factory_girl'

FactoryGirl.define do
   factory :model_program, class: Program do
      association :place, factory: :model_place

      title       'Sample Program'
      category    '能'
      shimai      true
      duration    90

      trait :start_from_this do
         after(:create) do |program|
            FactoryGirl.create(:model_event_program, program: program)
         end
      end
   end

   factory :another_program, class: Program do
      association :place, factory: :another_place

      title       'Another Program'
      category    '能'
      shimai      true
      duration    90

      trait :start_from_this do
         after(:create) do |program|
            FactoryGirl.create(:another_event_program, program: program)
         end
      end
   end

   factory :controller_program, class: Program do
      association :place, factory: :controller_place

      title       'Controller Program'
      category    '能'
      shimai      true
      duration    90

      trait :start_from_this do
         after(:create) do |program|
            FactoryGirl.create(:controller_event_program, program: program)
         end
      end
   end

   factory :different_program, class: Program do
      association :place, factory: :different_place

      title       'Different Program'
      category    '能'
      shimai      true
      duration    90

      trait :start_from_this do
         after(:create) do |program|
            FactoryGirl.create(:different_event_program, program: program)
         end
      end
   end

   factory :first_search_program, class: Program do
      association :place, factory: :search_program_place

      title       '橋弁慶'
      category    '能'
      shimai      true
      duration    90

   end

   factory :second_search_program, class: Program do
      association :place, factory: :search_program_place

      title       '隅田川'
      category    '能'
      shimai      true
      duration    90

   end
end

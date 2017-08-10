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

      title       'Different Program'
      category    '能'
      shimai      true
      duration    90

      trait :start_from_this do
         after(:create) do |program|
            FactoryGirl.create(:another_event_program, program: program)
         end
      end
   end
end

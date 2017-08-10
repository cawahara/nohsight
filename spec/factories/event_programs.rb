require 'factory_girl'

FactoryGirl.define do
   factory :model_event_program, class: EventProgram do
      association :event, factory: :model_event
      association :program, factory: :model_program

      style 'Simple'
      genre 'Sample'

      trait :start_from_this do
         after(:create) do |event_program|
            FactoryGirl.create(:model_event_performer, event_program: event_program)
         end
      end
   end

   factory :another_event_program, class: EventProgram do
      association :event, factory: :another_event
      association :program, factory: :another_program

      style 'Another'
      genre 'Sample'

      trait :start_from_this do
         after(:create) do |event_program|
            FactoryGirl.create(:another_event_performer, event_program: event_program)
         end
      end
   end
end

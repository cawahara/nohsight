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

   factory :controller_event_program, class: EventProgram do
      association :event, factory: :controller_event
      association :program, factory: :controller_program

      style 'Controller'
      genre 'Sample'

      trait :start_from_this do
         after(:create) do |event_program|
            FactoryGirl.create(:controller_event_performer, event_program: event_program)
         end
      end
   end

   factory :different_event_program, class: EventProgram do
      association :event, factory: :different_event
      association :program, factory: :different_program

      style 'Different'
      genre 'Sample'

      trait :start_from_this do
         after(:create) do |event_program|
            FactoryGirl.create(:different_event_performer, event_program: event_program)
         end
      end
   end

   factory :first_search_event_program, class: EventProgram do
      association :event, factory: :first_search_event
      association :program, factory: :first_search_program

      style 'Controller'
      genre 'Sample'

      after(:create) do |event_program|
         FactoryGirl.create(:first_search_event_performer, event_program: event_program)
      end
   end

   factory :second_search_event_program, class: EventProgram do
      association :event, factory: :second_search_event
      association :program, factory: :first_search_program

      style 'Controller'
      genre 'Sample'

      after(:create) do |event_program|
         FactoryGirl.create(:second_search_event_performer, event_program: event_program)
      end
   end

   factory :third_search_event_program, class: EventProgram do
      association :event, factory: :third_search_event
      association :program, factory: :first_search_program

      style 'Controller'
      genre 'Sample'

      after(:create) do |event_program|
         FactoryGirl.create(:third_search_event_performer, event_program: event_program)
      end
   end

   factory :fourth_search_event_program, class: EventProgram do
      association :event, factory: :fourth_search_event
      association :program, factory: :second_search_program

      style 'Controller'
      genre 'Sample'

      after(:create) do |event_program|
         FactoryGirl.create(:fourth_search_event_performer, event_program: event_program)
      end
   end

   factory :fifth_search_event_program, class: EventProgram do
      association :event, factory: :fifth_search_event
      association :program, factory: :second_search_program

      style 'Controller'
      genre 'Sample'

      after(:create) do |event_program|
         FactoryGirl.create(:fifth_search_event_performer, event_program: event_program)
      end
   end
end

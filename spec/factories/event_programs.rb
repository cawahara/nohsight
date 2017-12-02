# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
   factory :model_event_program, class: EventProgram do
      association :event, factory: :model_event
      association :program, factory: :model_program

      genre 'Sample'

      trait :start_from_this do
         after(:create) do |event_program|
            FactoryBot.create(:model_event_performer, event_program: event_program)
         end
      end
   end

   factory :another_event_program, class: EventProgram do
      association :event, factory: :another_event
      association :program, factory: :another_program

      genre 'Sample'

      trait :start_from_this do
         after(:create) do |event_program|
            FactoryBot.create(:another_event_performer, event_program: event_program)
         end
      end
   end

   factory :controller_event_program, class: EventProgram do
      association :event, factory: :controller_event
      association :program, factory: :controller_program

      genre 'Sample'

      trait :start_from_this do
         after(:create) do |event_program|
            FactoryBot.create(:controller_event_performer, event_program: event_program)
         end
      end
   end

   factory :different_event_program, class: EventProgram do
      association :event, factory: :different_event
      association :program, factory: :different_program

      genre 'Sample'

      trait :start_from_this do
         after(:create) do |event_program|
            FactoryBot.create(:different_event_performer, event_program: event_program)
         end
      end
   end

   factory :first_search_event_program, class: EventProgram do
      association :event, factory: :first_search_event
      association :program, factory: :first_search_program

      genre 'Sample'

      after(:create) do |event_program|
         FactoryBot.create(:first_search_event_performer, event_program: event_program)
      end
   end

   factory :second_search_event_program, class: EventProgram do
      association :event, factory: :second_search_event
      association :program, factory: :first_search_program

      genre 'Sample'

      after(:create) do |event_program|
         FactoryBot.create(:second_search_event_performer, event_program: event_program)
      end
   end

   factory :third_search_event_program, class: EventProgram do
      association :event, factory: :third_search_event
      association :program, factory: :first_search_program

      genre 'Sample'

      after(:create) do |event_program|
         FactoryBot.create(:third_search_event_performer, event_program: event_program)
      end
   end

   factory :fourth_search_event_program, class: EventProgram do
      association :event, factory: :fourth_search_event
      association :program, factory: :second_search_program

      genre 'Sample'

      after(:create) do |event_program|
         FactoryBot.create(:fourth_search_event_performer, event_program: event_program)
      end
   end

   factory :fifth_search_event_program, class: EventProgram do
      association :event, factory: :fifth_search_event
      association :program, factory: :second_search_program

      genre 'Sample'

      after(:create) do |event_program|
         FactoryBot.create(:fifth_search_event_performer, event_program: event_program)
      end
   end

   factory :sixth_search_event_program, class: EventProgram do
      association :event, factory: :sixth_search_event
      association :program, factory: :third_search_program

      genre 'Sample'

      after(:create) do |event_program|
         FactoryBot.create(:sixth_search_event_performer, event_program: event_program)
      end
   end
end

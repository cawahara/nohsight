# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
   factory :model_program, class: Program do
      title       'Sample Program'
      category    '能'
      shimai      true
      duration    90

      trait :start_from_this do
         after(:create) do |program|
            FactoryBot.create(:model_event_program, program: program)
         end
      end
   end

   factory :another_program, class: Program do
      title       'Another Program'
      category    '能'
      shimai      true
      duration    90

      trait :start_from_this do
         after(:create) do |program|
            FactoryBot.create(:another_event_program, program: program)
         end
      end
   end

   factory :controller_program, class: Program do
      title       'Controller Program'
      category    '能'
      shimai      true
      duration    90

      trait :start_from_this do
         after(:create) do |program|
            FactoryBot.create(:controller_event_program, program: program)
         end
      end

      trait :invalid_params do
         title  nil
      end

      trait :program_show_action do
         after(:create) do |program|
            5.times do |n|
               FactoryBot.create(:controller_event_program, program: program)
            end
         end
      end
   end

   factory :different_program, class: Program do
      title       'Different Program'
      category    '能'
      shimai      true
      duration    90

      trait :start_from_this do
         after(:create) do |program|
            FactoryBot.create(:different_event_program, program: program)
         end
      end
   end

   factory :first_search_program, class: Program do
      title       '橋弁慶'
      category    '能'
      shimai      true
      duration    90
   end

   factory :second_search_program, class: Program do
      title       '隅田川'
      category    '能'
      shimai      true
      duration    90
   end

   factory :third_search_program, class: Program do
      title       '殺生積'
      category    '能'
      shimai      true
      duration    90
   end
end

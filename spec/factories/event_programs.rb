require 'factory_girl'

FactoryGirl.define do
   factory :model_event_program, class: EventProgram do
      association :event, factory: :model_event
      association :program, factory: :model_program

      style 'Simple'
      genre 'Sample'
   end
end

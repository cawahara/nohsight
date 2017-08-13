require 'factory_girl'

FactoryGirl.define do
   factory :model_event_performer, class: EventPerformer do
      association :performer, factory: :model_performer
      association :event_program, factory: :model_event_program
   end

   factory :another_event_performer, class: EventPerformer do
      association :performer, factory: :another_performer
      association :event_program, factory: :another_event_program
   end

   factory :controller_event_performer, class: EventPerformer do
      association :performer, factory: :controller_performer
      association :event_program, factory: :controller_event_program
   end
end

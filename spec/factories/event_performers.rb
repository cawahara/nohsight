require 'factory_girl'

FactoryGirl.define do
   factory :model_event_performer, class: EventPerformer do
      association :performer, factory: :model_performer
      association :event_program, factory: :model_event_program
   end

   factory :diff_event_performer, class: EventPerformer do
      association :performer, factory: :diff_performer
      association :event_program, factory: :diff_event_program
   end
end

require 'factory_girl'

FactoryGirl.define do
   factory :model_ticket, class: Ticket do
      association :event, factory: :model_event

      grade    'Great class'
      price    7000
   end

   factory :diff_ticket, class: Ticket do
      association :event, factory: :model_event

      grade    'Another class'
      price    2500
   end
end

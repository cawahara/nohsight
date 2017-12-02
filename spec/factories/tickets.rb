# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
   factory :model_ticket, class: Ticket do
      association :event, factory: :model_event

      grade    'Great class'
      price    7000
   end

   factory :another_ticket, class: Ticket do
      association :event, factory: :another_event

      grade    'Another class'
      price    2500
   end

   factory :controller_ticket, class: Ticket do
      association :event, factory: :controller_event

      grade    'Controller class'
      price    2500
   end

   factory :different_ticket, class: Ticket do
      association :event, factory: :different_event

      grade    'Different class'
      price    2500
   end
end

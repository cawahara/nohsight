# frozen_string_literal: true

require 'factory_girl'

FactoryGirl.define do
   factory :model_point_record, class: PointRecord do
      association :user, factory: :model_user
      action  'Create new event'
      point   10
   end

   factory :another_point_record, class: PointRecord do
      association :user, factory: :another_user
      action  'Update current event'
      point   10
   end
end

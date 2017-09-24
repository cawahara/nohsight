# frozen_string_literal: true

require 'factory_girl'

FactoryGirl.define do
  factory :model_comment, class: Comment do
     association :user, factory: :model_user
     association :event, factory: :model_event

     content "Need to add more information"
  end

  factory :another_comment, class: Comment do
     association :user, factory: :another_user
     association :event, factory: :another_event

     content "Wrong information"
  end
end

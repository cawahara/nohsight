# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :model_bookmark, class: Bookmark do
     association :user, factory: :model_user
     association :event, factory: :model_event
  end

  factory :another_bookmark, class: Bookmark do
     association :user, factory: :another_user
     association :event, factory: :another_event
  end

  factory :controller_bookmark, class: Bookmark do
     association :user, factory: :controller_user
     association :event, factory: :controller_event
  end
end

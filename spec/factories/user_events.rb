# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :model_user_event, class: UserEvent do
     association :user, factory: :model_user
     association :event, factory: :model_event

     organizer true
  end

  factory :another_user_event, class: UserEvent do
     association :user, factory: :another_user
     association :event, factory: :another_event

     organizer true
  end

  factory :controller_user_event, class: UserEvent do
     association :user, factory: :controller_user
     association :event, factory: :controller_event

     organizer true
  end

  factory :different_user_event, class: UserEvent do
     association :user, factory: :different_user
     association :event, factory: :different_event

     organizer true
  end

  factory :first_search_user_event, class: UserEvent do
     association :user, factory: :search_user
     association :event, factory: :first_search_event

     organizer true
  end

  factory :second_search_user_event, class: UserEvent do
     association :user, factory: :search_user
     association :event, factory: :second_search_event

     organizer true
  end

  factory :third_search_user_event, class: UserEvent do
     association :user, factory: :search_user
     association :event, factory: :third_search_event

     organizer true
  end

  factory :fourth_search_user_event, class: UserEvent do
     association :user, factory: :search_user
     association :event, factory: :fourth_search_event

     organizer true
  end

  factory :fifth_search_user_event, class: UserEvent do
     association :user, factory: :search_user
     association :event, factory: :fifth_search_event

     organizer true
  end

  factory :sixth_search_user_event, class: UserEvent do
     association :user, factory: :search_user
     association :event, factory: :sixth_search_event

     organizer true
  end
end

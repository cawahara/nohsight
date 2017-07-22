FactoryGirl.define do
  factory :model_user_event, class: UserEvent do
     association :user, factory: :model_user
     association :event, factory: :model_event
  end
end

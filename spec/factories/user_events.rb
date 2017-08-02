FactoryGirl.define do
  factory :model_user_event, class: UserEvent do
     association :user, factory: :model_user
     association :event, factory: :model_event

     organizer true
  end

  factory :diff_user_event, class: UserEvent do
     association :user, factory: :diff_user
     association :event, factory: :diff_event

     organizer true
  end

  factory :admin_user_event, class: UserEvent do
     association :user, factory: :admin_user
     association :event, factory: :admin_event

     organizer true
  end
end

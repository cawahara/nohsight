FactoryGirl.define do
  factory :model_join_history, class: JoinHistory do
     association :user, factory: :model_user
     association :event, factory: :model_event

     status    0
  end

  factory :another_join_history, class: JoinHistory do
     association :user, factory: :another_user
     association :event, factory: :another_event

     status    0
  end

  factory :controller_join_history, class: JoinHistory do
     association :user, factory: :controller_user
     association :event, factory: :controller_event

     status    0
  end

  factory :different_join_history, class: JoinHistory do
     association :user, factory: :different_user
     association :event, factory: :different_event

     status    0
  end
end

require 'factory_girl'

FactoryGirl.define do
   factory :model_style, class: Style do
      title   'Sample'

      trait :start_from_this do
         after(:create) do |style|
            FactoryGirl.create(:model_performer, style: style)
         end
      end
   end

   factory :another_style, class: Style do
      title   'Another'

      trait :start_from_this do
         after(:create) do |style|
            FactoryGirl.create(:another_performer, style: style)
         end
      end
   end

   factory :controller_style, class: Style do
      title   'Controller'

      trait :start_from_this do
         after(:create) do |style|
            FactoryGirl.create(:controller_performer, style: style)
         end
      end
   end

   factory :different_style, class: Style do
      title   'Different'

      trait :start_from_this do
         after(:create) do |style|
            FactoryGirl.create(:different_performer, style: style)
         end
      end
   end

   factory :search_style, class: Style do
      title   '検索用'
   end
end

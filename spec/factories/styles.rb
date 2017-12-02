require 'factory_girl'

FactoryGirl.define do
   factory :model_style, class: Style do
      title   'シテ方観世流'

      trait :start_from_this do
         after(:create) do |style|
            FactoryGirl.create(:model_performer, style: style)
         end
      end
   end

   factory :another_style, class: Style do
      title   'ワキ方金剛流'

      trait :start_from_this do
         after(:create) do |style|
            FactoryGirl.create(:another_performer, style: style)
         end
      end
   end

   factory :controller_style, class: Style do
      title   '小鼓方金春流'

      trait :start_from_this do
         after(:create) do |style|
            FactoryGirl.create(:controller_performer, style: style)
         end
      end
   end

   factory :different_style, class: Style do
      title   '狂言方高安流'

      trait :start_from_this do
         after(:create) do |style|
            FactoryGirl.create(:different_performer, style: style)
         end
      end
   end

   factory :first_search_style, class: Style do
      title   'シテ方大蔵流'
   end

   factory :second_search_style, class: Style do
      title   'ワキ方大蔵流'
   end

   factory :third_search_style, class: Style do
      title   '小鼓方大蔵流'
   end
end

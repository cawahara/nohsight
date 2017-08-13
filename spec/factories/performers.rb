require 'factory_girl'

FactoryGirl.define do
   factory :model_performer, class: Performer do
      association :style, factory: :model_style

      full_name   '田中 幸弘'
      last_name   'たなか'
      first_name  'ゆきひろ'

      trait :start_from_this do
         after(:create) do |performer|
            FactoryGirl.create(:model_event_performer, performer: performer)
         end
      end
   end

   factory :another_performer, class: Performer do
      association :style, factory: :another_style

      full_name   '松本 秀隆'
      last_name   'まつもと'
      first_name  'ひでたか'

      trait :start_from_this do
         after(:create) do |performer|
            FactoryGirl.create(:another_event_performer, performer: performer)
         end
      end
   end

   factory :controller_performer, class: Performer do
      association :style, factory: :controller_style

      full_name   '宇津井　薫'
      last_name   'うつい'
      first_name  'かおる'

      trait :start_from_this do
         after(:create) do |performer|
            FactoryGirl.create(:controller_event_performer, performer: performer)
         end
      end
   end

=begin
   factory :diff_performer, class: Performer do
      association :style, factory: :model_style

      full_name   '田中 光圀'
      last_name   'たなか'
      first_name  'みつくに'

   end
=end
end

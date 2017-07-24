require 'factory_girl'

FactoryGirl.define do
   factory :model_performer, class: Performer do
      association :style, factory: :model_style

      full_name   '田中 幸弘'
      last_name   'たなか'
      first_name  'ゆきひろ'

   end

   factory :diff_performer, class: Performer do
      association :style, factory: :model_style

      full_name   '田中 光圀'
      last_name   'たなか'
      first_name  'みつくに'

   end
end

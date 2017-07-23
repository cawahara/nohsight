require 'factory_girl'

FactoryGirl.define do
   factory :model_program, class: Program do
      association :place, factory: :model_place

      title       'Sample Program'
      category    '能'
      shimai      true
      duration    90
   end

   factory :diff_program, class: Program do
      association :place, factory: :model_place

      title       'Different Program'
      category    '能'
      shimai      true
      duration    90
   end
end

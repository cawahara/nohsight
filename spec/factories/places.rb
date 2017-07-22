require 'factory_girl'

FactoryGirl.define do
  factory :model_place, class: Place do
     title        'Temple'
     address      'kyoto'
     official_url 'http://www.temple.com'

     initialize_with { Place.find_or_create_by(title: title) }
  end
end

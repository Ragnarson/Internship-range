FactoryGirl.define do
  factory :address do
    city 'York'
    building 11
    association :shooter
    zip_code '92-108'
  end

  factory :other_address, :class => Address do
    city 'London'
    building 12
    association :shooter
    zip_code '92-107'
  end

  factory :invalid_address, :class => Address do
    city nil
    building nil
    zip_code nil
  end
end

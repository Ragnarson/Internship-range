FactoryGirl.define do
  factory :contest do
    sequence(:name) { |n| "Contest#{n}" }
    date '2014-08-26'.to_date
  end

  factory :other_contest, :class => Contest do
    name "Zawody"
    date '2014-01-03'.to_date
  end

  factory :invalid_contest, :class => Contest do
    name nil
    date nil
  end
end

FactoryGirl.define do
  factory :contest do
    name 'Big contest'
    date '2014-08-26'.to_date
  end

  factory :other_contest, :class => Contest do
    name 'Zawody2'
    date '2014-04-04'.to_date
  end

  factory :invalid_contest, :class => Contest do
    name nil
    date nil
  end
end

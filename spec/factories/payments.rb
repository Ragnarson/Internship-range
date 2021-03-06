FactoryGirl.define do
  factory :payment do
    amount 1
    description 'description'
    association :shooter
    date '2010-01-01'.to_date
  end

  factory :other_payment, :class => Payment do
    amount 2.53
    description 'other description'
    association :shooter
    date '2011-11-11'.to_date
  end

  factory :invalid_payment, :class => Payment do
    amount nil
    description nil
    date nil
  end
end

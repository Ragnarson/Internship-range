FactoryGirl.define do
  factory :payment do
    amount 1
    description "description"
    association :shooter
    date "2010-01-01"
  end
end

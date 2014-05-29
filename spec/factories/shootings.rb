# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shooting do
    association :competitor
    association :competition
  end

  factory :other_shooting, class: Shooting do
    association :competition
    association :competitor
  end

  factory :invalid_shooting do
    target nil
    competition nil
    competitor nil
  end
end

FactoryGirl.define do
  factory :shooting do
    association :competitor
    association :competition
    target ['1', '2', '3', '4', '5', '6', '7', 'x', 'x', 'x']
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

FactoryGirl.define do
  factory :competition do
    association :contest
    sequence(:name) { |n| "PSP #{n}" }
    classification 'PSP 10'
    number_of_shots 10
  end

  factory :other_competition, :class => Competition do
    association :contest
    sequence(:name) { |n| "PSP #{n}" }
    classification 'PSP 8'
    number_of_shots 8
  end

  factory :invalid_competition, :class => Competition do
    name nil
    classification nil
    number_of_shots nil
  end
end

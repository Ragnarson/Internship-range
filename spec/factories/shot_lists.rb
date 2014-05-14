FactoryGirl.define do
  factory :shot_list do
    association :contest
    association :competition
    association :competitor
    shots [1,1,1,1,1,1,1,1]
  end

  factory :other_shot_list, :class => ShotList do
    association :contest
    association :competition
    association :competitor
    shots [2,2,2,2,2,2,2,2]
  end

  factory :invalid_shot_list, :class => ShotList do
    shots nil
  end
end
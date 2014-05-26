FactoryGirl.define do
  factory :contest do
    name 'Big contest'
    date '2014-08-26'.to_date
  end

  factory :other_contest, class: Contest do
    name 'Zawody2'
    date '2014-04-04'.to_date
  end

  factory :invalid_contest, class: Contest do
    name nil
    date nil
  end

  factory :contests_archive do
    name 'Big party'
    date '2014-08-23'.to_date
    active false
  end

  factory :other_contests_archive, class: ContestsArchive do
    name 'Small Contest'
    date '2014-08-12'.to_date
    active false
  end
end

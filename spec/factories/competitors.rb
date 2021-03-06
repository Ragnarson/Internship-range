FactoryGirl.define do
  factory :competitor do
    association :contest
    first_name 'Firstname'
    last_name 'Lastname'
    date_of_birth '2010-10-10'.to_date
    club 'Topgun'
    pk false
  end

  factory :other_competitor, :class => Competitor do
    association :contest
    first_name 'Secondname'
    last_name 'Thirdname'
    date_of_birth '2011-11-11'.to_date
    club 'Gun'
  end

  factory :invalid_competitor, :class => Competitor do
    first_name nil
    last_name nil
    date_of_birth nil
    club nil
  end
end

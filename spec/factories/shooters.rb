FactoryGirl.define do
  factory :shooter do
    first_name 'Firstname'
    last_name 'Lastname'
    email 'foobar@example.com'
    date_of_birth '2010-10-10'.to_date
    pesel '22031304231'
    initialize_with { Shooter.find_or_initialize_by(pesel: pesel) }
    joined_date '2010-10-10'.to_date
    after(:build) do |shooter, evaluator|
      shooter.addresses << build_list(:address, 1, shooter: nil)
    end
    active true
  end

  factory :other_shooter, class: Shooter do
    first_name 'Secondname'
    last_name 'Thirdname'
    email 'barfoo@example.com'
    date_of_birth '2010-11-11'.to_date
    pesel '33031304242'
    initialize_with { Shooter.find_or_initialize_by(pesel: pesel) }
    joined_date '2010-11-11'.to_date
    after(:build) do |shooter, evaluator|
      shooter.addresses << build_list(:address, 1, shooter: nil)
    end
  end

  factory :invalid_shooter, class: Shooter do
    first_name nil
    last_name nil
    email nil
    date_of_birth nil
    pesel nil
    joined_date nil
  end

  factory :nonactive_shooter, class: Shooter do
    first_name 'Othername'
    last_name 'Iname'
    email 'ala@example.com'
    date_of_birth '2010-10-10'.to_date
    pesel '44031304231'
    initialize_with { Shooter.find_or_initialize_by(pesel: pesel) }
    joined_date '2010-10-10'.to_date
    after(:build) do |shooter, evaluator|
      shooter.addresses << build_list(:address, 1, shooter: nil)
    end
    active false
  end
end

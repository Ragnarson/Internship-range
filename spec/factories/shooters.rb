FactoryGirl.define do
  factory :shooter do
    first_name 'Firstname'
    last_name 'Lastname'
    date_of_birth '2010-10-10'
    pesel '22031304231'
    joined_date '2010-10-10'
  end

  factory :other_shooter, :class => Shooter do
    first_name 'Secondname'
    last_name 'Thirdname'
    date_of_birth '2010-11-11'
    pesel '33031304242'
    joined_date '2010-11-11'
  end

  factory :invalid_shooter, :class => Shooter do
    first_name nil
    last_name nil
    date_of_birth nil
    pesel nil
    joined_date nil
  end
end

FactoryGirl.define do
  factory :judge do
    first_name 'Firstname'
    last_name 'Lastname'
    function 'Function'
    license_number '22031304231'
  end

  factory :other_judge, :class => Judge do
    first_name 'Secondname'
    last_name 'Thirdname'
    function 'Other function'
    license_number '33031304255'
  end

  factory :invalid_judge, :class => Judge do
    first_name nil
    last_name nil
    function nil
    license_number nil
  end
end

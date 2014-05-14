FactoryGirl.define do
  factory :user do
    password 'Securepass'
    password_confirmation 'Securepass'
    email 'mike@example.com'
  end

  factory :other_user, :class => User do
    password 'Securepass2'
    password_confirmation 'Securepass2'
    email 'john@example.com'
  end

  factory :invalid_user, :class => User do
    password nil
    password_confirmation nil
    email nil
  end
end

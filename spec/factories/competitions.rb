FactoryGirl.define do
  factory :competition do
    association :contest
    name { 'Shooting stars' }
    classification { 'PSP 10' }
    number_of_shots { 10 }
  end
end

FactoryBot.define do
  factory :account do
    sequence :email do |n|
      "test#{n}@gmail.com"
    end
    name {"Naren"}
    password {"Naren123@"}
    password_confirmation {"Naren123@"}
    trait :for_user do
      association :accountable, factory: :user
    end

    trait :for_renter do
      association :accountable, factory: :renter
    end
  end
end

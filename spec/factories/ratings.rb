FactoryBot.define do
  factory :rating do
    rating {5}
    comment {"good"}
    from_id {20}

    trait :for_product do
      association :ratable, factory: :product
    end

    trait :for_renter do
      association :ratable, factory: :renter
    end
  end
end

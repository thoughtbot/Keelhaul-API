FactoryGirl.define do
  factory :receipt do
    environment "production"
    device_hash "some-hash"
    user
  end

  factory :user do
    sequence(:email) { |n| "user+#{n}@example.com" }
    password "abc123"

    trait :admin do
      admin true
    end
  end
end

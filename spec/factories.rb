FactoryGirl.define do
  factory :receipt do
    user
    token "some-token"
  end

  factory :user do
    sequence(:email) { |n| "user+#{n}@example.com" }
    password "abc123"
  end
end

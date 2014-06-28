FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password 'password'
    password_confirmation 'password'

    trait :admin do
      role :admin
    end
  end
end
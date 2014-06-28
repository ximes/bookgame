FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    trait :admin do
      role :admin
    end
  end
  
  factory :user_with_book, :parent => :user do
    books { |b| [b.association(:book)] }
  end


end
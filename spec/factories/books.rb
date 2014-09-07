FactoryGirl.define do
  factory :book do
    title 'title'

    trait :publishable do
    	publishable true
    	completed true
    end
  end
  factory :book_with_user, :parent => :book do
    users { |u| [u.association(:user_with_book)] }
  end
  factory :book_with_chapters, :parent => :book do
    chapters { |c| [c.association(:chapter)] }
  end
end
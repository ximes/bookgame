FactoryGirl.define do
  factory :book do
    title 'title'
  end
  factory :book_with_user, :parent => :book do
    users { |u| [u.association(:user_with_book)] }
  end
end
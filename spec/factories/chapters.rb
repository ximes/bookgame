# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chapter do
    sequence(:id)
    title "Chapter"
    introtext "IntroText"
    fulltext "FullText"
    active false
    death false
    ending false
    beginning false
    book nil
  end

  factory :chapter_with_book, :parent => :chapter do
    book { |b| b.association(:book) }
  end

  factory :chapter_with_user, :parent => :chapter do
    book { |b| b.association(:book_with_user) }
  end
end

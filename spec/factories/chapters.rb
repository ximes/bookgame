# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chapter do
    sequence(:id)
    sequence(:title) { |n| "Chapter #{n}" }
    introtext "IntroText"
    fulltext "FullText"
    completed false
    death false
    ending false
    beginning nil
    book nil
  end

  factory :chapter_completed, :parent => :chapter do
    completed true
  end

  factory :chapter_uncompleted, :parent => :chapter do
    completed false
  end

  factory :chapter_with_book, :parent => :chapter do
    book { |b| b.association(:book) }
  end

  factory :chapter_with_user, :parent => :chapter do
    book { |b| b.association(:book_with_user) }
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chapter do
    title "MyString"
    introtext "MyText"
    fulltext "MyText"
    active false
    death false
    ending false
    beginning false
    book nil
  end
end

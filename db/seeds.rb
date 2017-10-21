#creates an admin
User.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  role: :admin
)

# creates two users
user = User.create!(
  email: "user1@example.com",
  password: "password",
  password_confirmation: "password",
  books: [Book.new(title: "title")]
)

parent_chapter = Chapter.new(
    title: "Chapter 0",
    introtext: "IntroText",
    fulltext: "FullText",
    completed: false,
    death: false,
    ending: false,
    beginning: nil,
    book: nil,
)

parent_chapter.book = user.books.first
parent_chapter.beginning = true
parent_chapter.save!

12.times do |i|
  chapter = Chapter.new(
    title: "Chapter #{i+1}",
    introtext: "IntroText",
    fulltext: "FullText",
    completed: false,
    death: false,
    ending: false,
    beginning: nil,
    book: user.books.first,
  )
  chapter.save!
  parent_chapter = chapter
end

last_chapter = Chapter.new(
    title: "Chapter 13",
    introtext: "IntroText",
    fulltext: "FullText",
    completed: false,
    death: true,
    ending: true,
    beginning: nil,
    book: user.books.first,
)
last_chapter.save!

chapters = Chapter.where(book: user.books.first)

(2..(chapters.count)).to_a.shuffle

chapters.each do |chapter|
  chapter.fulltext = "[link_to_chapter #{rand(chapters.count)}]"
  #ct.pop
  chapter.save!
end

2.times do
  chapter = chapters[rand(chapters.count)]
  chapter.death = true
  chapter.save!
end

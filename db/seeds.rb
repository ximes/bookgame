require 'factory_girl_rails'

#creates an admin
FactoryGirl.create :user, :admin

#creates two users
user = FactoryGirl.create :user_with_book

FactoryGirl.reload

parent_chapter = FactoryGirl.create :chapter_completed
parent_chapter.book = user.books.first
parent_chapter.beginning = true
parent_chapter.save!

12.times do |i|

	chapter = FactoryGirl.create :chapter
	chapter.book = user.books.first
	
	#parent_chapter.fulltext = "[link_to_chapter #{rand(i) - 1}]"
	parent_chapter.save!

	chapter.save!

	parent_chapter = chapter
end

last_chapter = FactoryGirl.create :chapter_completed
last_chapter.book = user.books.first
last_chapter.death = last_chapter.ending = true
last_chapter.save!

chapters = Chapter.where(:book => user.books.first)

ct = (2..(chapters.count )).to_a.shuffle 

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
class Book < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :chapters

	accepts_nested_attributes_for :chapters
end

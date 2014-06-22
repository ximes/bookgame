class Chapter < ActiveRecord::Base
#  has_many :links, foreign_key: "person_a_id"
#  has_many :people, :through => :links, :source => :person_b
#  scope :patients, -> { where(type: "Patient") }
#  scope :users, -> { where(type: "User") }

#  set_primary_key "chapter_id"
	belongs_to :book

	has_many :parent_chapters, :foreign_key => 'chapter_id', :class_name => 'Chaptership'
	has_many :child_chapters, :foreign_key => 'parent_id', :class_name => 'Chaptership'

	has_many :parents, :through => :parent_chapters, :source => :parent
	has_many :children, :through => :child_chapters, :source => :chapter

	accepts_nested_attributes_for :parent_chapters, :allow_destroy => true

end
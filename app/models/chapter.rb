class Chapter < ActiveRecord::Base

	has_paper_trail

	belongs_to :book

	validates :title, :presence => true

	has_many :parent_chapters, :foreign_key => 'chapter_id', :class_name => 'Chaptership'
	has_many :child_chapters, :foreign_key => 'parent_id', :class_name => 'Chaptership'

	has_many :parents, :through => :parent_chapters, :source => :parent
	has_many :children, :through => :child_chapters, :source => :chapter

	accepts_nested_attributes_for :parent_chapters, :allow_destroy => true

end
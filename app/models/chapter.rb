class Chapter < ActiveRecord::Base

	has_paper_trail

	belongs_to :book

	validates :title, :presence => true

	has_many :parent_chapters, :foreign_key => 'chapter_id', :class_name => 'Chaptership'
	has_many :child_chapters, :foreign_key => 'parent_id', :class_name => 'Chaptership'

	has_many :parents, :through => :parent_chapters, :source => :parent
	has_many :children, :through => :child_chapters, :source => :chapter

	accepts_nested_attributes_for :parent_chapters, :allow_destroy => false

	
	after_save :set_chapter_relations

	private

	def set_chapter_relations
		chapters_linked = fulltext.scan(/\[link_to_chapter (\w*)\]/).flatten.uniq
		child_chapters.each {|c| c.destroy}
		unless chapters_linked.empty?
			chapters_linked.map do |child_chapter|
			  chapter = Chapter.find_by_id(child_chapter)
			  if chapter && chapter.book == self.book
			    child_chapters.create!(:parent => self, :chapter => chapter)
			  else
			    field = fulltext.gsub(/\[link_to_chapter #{Regexp.quote(child_chapter)}\]/, "")
			    self.fulltext = field
			  end
			end
		end
    end
end
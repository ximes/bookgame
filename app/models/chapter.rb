class Chapter < ActiveRecord::Base

	has_paper_trail

	belongs_to :book

	acts_as_list scope: :book

	validates :title, :presence => true

	has_many :parent_chapters, :foreign_key => 'chapter_id', :class_name => 'Chaptership'
	has_many :child_chapters, :foreign_key => 'parent_id', :class_name => 'Chaptership'

	has_many :parents, :through => :parent_chapters, :source => :parent
	has_many :children, :through => :child_chapters, :source => :chapter

	accepts_nested_attributes_for :parent_chapters, :allow_destroy => false

	after_save :set_chapter_relations, :set_beginning, :set_ending

	scope :by_print_order, -> { order(:beginning).reverse_order}
	scope :by_order, -> { order(:position)}

    def ending_or_death?
    	ending? || death?
	end

	private

	def set_chapter_relations
		chapters_linked = fulltext.scan(/\[#{LINK_REPLACEMENT_TEXT} (\w*)\]/).flatten.uniq
		child_chapters.each {|c| c.destroy}
		unless chapters_linked.empty?
			chapters_linked.map do |child_chapter|
			  chapter = Chapter.find_by_id(child_chapter)
			  if chapter && chapter.book == self.book && !ending_or_death?
			    child_chapters.create!(:parent => self, :chapter => chapter)
			  else
			    field = fulltext.gsub(/\[#{LINK_REPLACEMENT_TEXT} #{Regexp.quote(child_chapter)}\]/, "#{LINK_REMOVED_TEXT}")
			    self.update_column(:fulltext, field)
			  end
			end
		end
    end

    def set_beginning
		if parents.empty?
			self.update_column(:beginning, true)
		else
			self.update_column(:beginning, false)
		end
    	unless children.empty?
			children.each do |chapter|
				chapter.update_column(:beginning, false)
			end
		end
	end
    def set_ending
    	if death?
			self.update_column(:ending, true)
		end
	end
end
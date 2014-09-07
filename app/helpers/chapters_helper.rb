module ChaptersHelper
	def shortcode_to_link(chapter, var, replacements)
		field = chapter.send(var)
		chapters_linked = field.scan(/\[#{LINK_REPLACEMENT_TEXT} (\w*)\]/).flatten.uniq
		unless chapters_linked.empty?
			chapters_linked.map do |child_chapter|
			  current_child_chapter = Chapter.find_by_id(child_chapter)
			  if current_child_chapter && current_child_chapter.book == chapter.book
				field = field.gsub(/\[#{LINK_REPLACEMENT_TEXT} #{current_child_chapter.id}\]/, "<a href=\"##{current_child_chapter.id}\">#{replacements.index(current_child_chapter.id)}</a>".html_safe)
			  end
			end
		end
		field.html_safe
	end
end

require 'spec_helper'

describe Chapter do
	context "validations" do
	  	describe "with children" do
	  		let(:other_chapter) {create(:chapter_with_book)}
			before (:each){
				@chapter = Chapter.create!({
			        :fulltext => "[link_to_chapter #{other_chapter.id}]",
			        :title => "Chapter 1",
			        :book => other_chapter.book
		      	}) 
			}
		    it "should be valid" do
		      @chapter.should be_valid
		    end
		    it "should have a child chapter" do
		      @chapter.children.should include(other_chapter)
		    end
		    it "should be set as beginning" do
		      @chapter.beginning?.should be_true
		    end
	    end
		
		describe "with parents" do
			let(:other_chapter) {create(:chapter_with_book)}
			before (:each){
				@chapter = Chapter.create!({
			        :fulltext => "text",
			        :title => "Chapter 1",
			        :book => other_chapter.book
		      	})
		      	@chapter.parent_chapters.create!(:parent => other_chapter, :chapter => @chapter)
		      	@chapter.save!
			}
		    it "should be valid" do
		      @chapter.should be_valid
		    end
		    it "should have a child chapter" do
		      @chapter.parents.should include(other_chapter)
		    end
			it "should not be set as beginning" do
		      @chapter.beginning?.should be_false
		    end
	    end


	end
end
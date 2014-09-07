require 'spec_helper'

describe Book do
  let (:book){ 
  	Book.new(:title => "title")
  }

  subject { book }

  it { should have_and_belong_to_many :users }

	context "complete/uncomplete action" do
		 describe "child chapters" do
	    	let(:book) {create(:book)}
		    before(:each){
		      	book.stub(:chapters).and_return([mock_model(Chapter)])
		    }
		    it "should be completed" do
		    	book.chapters.each{|chapter|
		    		chapter.stub(:completable?).and_return(true)
		    		chapter.should_receive(:complete!)
		    	}
		    	book.complete!
		    end
		    it "shouldn't be completed" do
		    	book.chapters.each{|chapter|
		    		chapter.stub(:completable?).and_return(false)
		    		chapter.should_not_receive(:complete!)
		    	}
		    	book.complete!
		    end
	    end

		describe "when marked as published" do
	  		let(:book) {create(:book_with_chapters)}
			before(:each){ book.publish! }

		    it "should be published" do
		      book.publishable.should be_true
		    end
	    end	

		describe "when marked as unpublished" do
	  		let(:book) {create(:book_with_chapters)}
			before(:each){ book.unpublish! }

		    it "shouldn't be published" do
		      book.publishable.should be_false
		    end
	    end	

		describe "when marked as complete" do
	  		let(:book) {create(:book_with_chapters)}
			before(:each){ book.complete! }
		    it "should be completed" do
		      book.completed.should be_true
		    end
	    end	

		describe "when signed as uncomplete" do
	  		let(:book) {create(:book_with_chapters, :completed =>true)}
			before (:each){
				book.uncomplete!
			}
		    it "should be completed" do
		      book.completed.should be_false
		    end
	    end	
	end
end

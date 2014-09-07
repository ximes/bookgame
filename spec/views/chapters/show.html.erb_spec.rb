require 'spec_helper'

describe "chapters/show" do
  before(:each) do
    assign(:book, build_stubbed(:book))
    assign(:chapter, build_stubbed(:chapter_with_book))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Chapter/)
    rendered.should match(/FullText/)
    rendered.should match(/IntroText/)
  end
end

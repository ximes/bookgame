require 'spec_helper'

describe "chapters/index" do
  before(:each) do
    assign(:book, build_stubbed(:book))
    assign(:chapters, [
      build_stubbed(:chapter_with_book),
      build_stubbed(:chapter_with_book)
    ])
  end

  it "renders a list of chapters" do
    render
    assert_select "tr>td", :text => "Chapter".to_s, :count => 2
  end
end

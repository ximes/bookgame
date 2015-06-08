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
    assert_select "tr>td", /Chapter ([0-9]*)/, :count => 2
  end
end

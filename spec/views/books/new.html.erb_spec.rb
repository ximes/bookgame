require 'spec_helper'

describe "books/new" do
  before(:each) do
    @book = assign(:book, build_stubbed(:book))
  end

  it "renders new book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", book_path(@book), "post" do
      assert_select "input#book_title[name=?]", "book[title]"
    end
  end
end

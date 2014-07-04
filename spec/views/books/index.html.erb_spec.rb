require 'spec_helper'

describe "books/index" do
  before(:each) do
    assign(:books, [
      build_stubbed(:book, :title => "First Book"),
      build_stubbed(:book, :title => "Second Book")
    ])
    assign(:other_books, [
      build_stubbed(:book, :title => "Other Book")
    ])
  end

  it "renders a list of books" do
    render
    assert_select "div.book", :minimum => 2
    assert_select "div.book h3 a", :text => "First Book", :count => 1
    assert_select "div.book h3 a", :text => "Second Book", :count => 1
  end
  
  it "renders a list of other books" do
    render
    assert_select "div.book h3 a", :text => "Other Book", :count => 1
  end
end

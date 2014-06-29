require 'spec_helper'

describe "chapters/new" do
  before(:each) do
    @book = assign(:book, build_stubbed(:book))
    @chapter = assign(:chapter, build_stubbed(:chapter_with_book))
  end

  it "renders new chapter form" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", book_chapter_path(@book, @chapter), "post" do
      assert_select "input#chapter_title[name=?]", "chapter[title]"
      assert_select "textarea#chapter_introtext[name=?]", "chapter[introtext]"
      assert_select "textarea#chapter_fulltext[name=?]", "chapter[fulltext]"
      assert_select "input#chapter_active[name=?]", "chapter[active]"
      assert_select "input#chapter_death[name=?]", "chapter[death]"
      assert_select "input#chapter_ending[name=?]", "chapter[ending]"
      assert_select "input#chapter_beginning[name=?]", "chapter[beginning]"
    end
  end
end

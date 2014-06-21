require 'spec_helper'

describe "chapters/show" do
  before(:each) do
    @chapter = assign(:chapter, stub_model(Chapter,
      :title => "Title",
      :introtext => "MyText",
      :fulltext => "MyText",
      :active => false,
      :death => false,
      :ending => false,
      :beginning => false,
      :book => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(//)
  end
end

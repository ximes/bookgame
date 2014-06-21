require 'spec_helper'

describe "chapters/index" do
  before(:each) do
    assign(:chapters, [
      stub_model(Chapter,
        :title => "Title",
        :introtext => "MyText",
        :fulltext => "MyText",
        :active => false,
        :death => false,
        :ending => false,
        :beginning => false,
        :book => nil
      ),
      stub_model(Chapter,
        :title => "Title",
        :introtext => "MyText",
        :fulltext => "MyText",
        :active => false,
        :death => false,
        :ending => false,
        :beginning => false,
        :book => nil
      )
    ])
  end

  it "renders a list of chapters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

require 'spec_helper'

describe "articles/index" do
  before(:each) do
    assign(:articles, [
      stub_model(Article,
        :status => 1,
        :section => 2,
        :graveyard => nil,
        :author => nil,
        :headline => "Headline",
        :path => "Path",
        :teaser => "MyText",
        :body => "MyText"
      ),
      stub_model(Article,
        :status => 1,
        :section => 2,
        :graveyard => nil,
        :author => nil,
        :headline => "Headline",
        :path => "Path",
        :teaser => "MyText",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of articles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Headline".to_s, :count => 2
    assert_select "tr>td", :text => "Path".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

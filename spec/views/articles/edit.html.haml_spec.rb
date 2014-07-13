require 'spec_helper'

describe "articles/edit" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :status => 1,
      :section => 1,
      :graveyard => nil,
      :author => nil,
      :headline => "MyString",
      :path => "MyString",
      :teaser => "MyText",
      :body => "MyText"
    ))
  end

  it "renders the edit article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", article_path(@article), "post" do
      assert_select "input#article_status[name=?]", "article[status]"
      assert_select "input#article_section[name=?]", "article[section]"
      assert_select "input#article_graveyard[name=?]", "article[graveyard]"
      assert_select "input#article_author[name=?]", "article[author]"
      assert_select "input#article_headline[name=?]", "article[headline]"
      assert_select "input#article_path[name=?]", "article[path]"
      assert_select "textarea#article_teaser[name=?]", "article[teaser]"
      assert_select "textarea#article_body[name=?]", "article[body]"
    end
  end
end

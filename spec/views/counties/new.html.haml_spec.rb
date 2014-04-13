require 'spec_helper'

describe "counties/new" do
  before(:each) do
    assign(:county, stub_model(County,
      :state => nil,
      :name => "MyString",
      :county_type => 1,
      :path => "MyString",
      :full_path => "MyString"
    ).as_new_record)
  end

  it "renders new county form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", counties_path, "post" do
      assert_select "input#county_state[name=?]", "county[state]"
      assert_select "input#county_name[name=?]", "county[name]"
      assert_select "input#county_county_type[name=?]", "county[county_type]"
      assert_select "input#county_path[name=?]", "county[path]"
      assert_select "input#county_full_path[name=?]", "county[full_path]"
    end
  end
end

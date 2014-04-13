require 'spec_helper'

describe "counties/edit" do
  before(:each) do
    @county = assign(:county, stub_model(County,
      :state => nil,
      :name => "MyString",
      :type_name => 'County',
      :path => "MyString",
      :full_path => "MyString"
    ))
  end

  it "renders the edit county form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", county_path(@county), "post" do
      assert_select "input#county_state[name=?]", "county[state]"
      assert_select "input#county_name[name=?]", "county[name]"
      assert_select "input#county_type_name[name=?]", "county[type_name]"
      assert_select "input#county_path[name=?]", "county[path]"
      assert_select "input#county_full_path[name=?]", "county[full_path]"
    end
  end
end

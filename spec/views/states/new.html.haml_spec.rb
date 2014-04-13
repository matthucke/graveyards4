require 'spec_helper'

describe "states/new" do
  before(:each) do
    assign(:state, stub_model(State,
      :state_code => "MyString",
      :country_code => "MyString",
      :name => "MyString",
      :path => "MyString"
    ).as_new_record)
  end

  it "renders new state form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", states_path, "post" do
      assert_select "input#state_state_code[name=?]", "state[state_code]"
      assert_select "input#state_country_code[name=?]", "state[country_code]"
      assert_select "input#state_name[name=?]", "state[name]"
      assert_select "input#state_path[name=?]", "state[path]"
    end
  end
end

require 'spec_helper'

describe "states/edit" do
  before(:each) do
    @state = assign(:state, stub_model(State,
      :state_code => "MyString",
      :country_code => "MyString",
      :name => "MyString",
      :path => "MyString"
    ))
  end

  it "renders the edit state form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", state_path(@state), "post" do
      assert_select "input#state_state_code[name=?]", "state[state_code]"
      assert_select "input#state_country_code[name=?]", "state[country_code]"
      assert_select "input#state_name[name=?]", "state[name]"
      assert_select "input#state_path[name=?]", "state[path]"
    end
  end
end

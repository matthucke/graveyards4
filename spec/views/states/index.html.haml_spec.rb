require 'spec_helper'

describe "states/index" do
  before(:each) do
    assign(:states, [
      stub_model(State,
        :state_code => "State Code",
        :country_code => "Country Code",
        :name => "Name",
        :path => "Path"
      ),
      stub_model(State,
        :state_code => "State Code",
        :country_code => "Country Code",
        :name => "Name",
        :path => "Path"
      )
    ])
  end

  it "renders a list of states" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State Code".to_s, :count => 2
    assert_select "tr>td", :text => "Country Code".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Path".to_s, :count => 2
  end
end

require 'spec_helper'

describe "states/show" do
  before(:each) do
    @state = assign(:state, stub_model(State,
      :state_code => "State Code",
      :country_code => "Country Code",
      :name => "Name",
      :path => "Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/State Code/)
    rendered.should match(/Country Code/)
    rendered.should match(/Name/)
    rendered.should match(/Path/)
  end
end

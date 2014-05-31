require 'spec_helper'

describe "county_cemetery_lists/show" do
  before(:each) do
    @county_cemetery_list = assign(:county_cemetery_list, stub_model(CountyCemeteryList,
      :name => "Name",
      :state => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(//)
  end
end

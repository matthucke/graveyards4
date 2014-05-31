require 'spec_helper'

describe "county_cemetery_lists/index" do
  before(:each) do
    assign(:county_cemetery_lists, [
      stub_model(CountyCemeteryList,
        :name => "Name",
        :state => nil
      ),
      stub_model(CountyCemeteryList,
        :name => "Name",
        :state => nil
      )
    ])
  end

  it "renders a list of county_cemetery_lists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

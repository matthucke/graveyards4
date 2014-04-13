require 'spec_helper'

describe "counties/index" do
  before(:each) do
    assign(:counties, [
      stub_model(County,
        :state => nil,
        :name => "Name",
        :type_name => 'County',
        :path => "Path",
        :full_path => "Full Path"
      ),
      stub_model(County,
        :state => nil,
        :name => "Name",
        :type_name => 'County',
        :path => "Path",
        :full_path => "Full Path"
      )
    ])
  end

  it "renders a list of counties" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 'County'.to_s, :count => 2
    assert_select "tr>td", :text => "Path".to_s, :count => 2
    assert_select "tr>td", :text => "Full Path".to_s, :count => 2
  end
end

require 'spec_helper'

describe "expeditions/index" do
  before(:each) do
    assign(:expeditions, [
      stub_model(Expedition,
        :user => nil,
        :name => "Name",
        :notes => "MyText"
      ),
      stub_model(Expedition,
        :user => nil,
        :name => "Name",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of expeditions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

require 'spec_helper'

describe "graveyards/index" do
  before(:each) do
    assign(:graveyards, [
      stub_model(Graveyard,
        :feature_type => 1,
        :county => nil,
        :status => 2,
        :name => "Name",
        :path => "Path",
        :lat => "9.99",
        :lng => "9.99",
        :year_started => 3,
        :usgs_id => 4,
        :usgs_map => "Usgs Map",
        :homepage => "Homepage"
      ),
      stub_model(Graveyard,
        :feature_type => 1,
        :county => nil,
        :status => 2,
        :name => "Name",
        :path => "Path",
        :lat => "9.99",
        :lng => "9.99",
        :year_started => 3,
        :usgs_id => 4,
        :usgs_map => "Usgs Map",
        :homepage => "Homepage"
      )
    ])
  end

  it "renders a list of graveyards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Path".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Usgs Map".to_s, :count => 2
    assert_select "tr>td", :text => "Homepage".to_s, :count => 2
  end
end

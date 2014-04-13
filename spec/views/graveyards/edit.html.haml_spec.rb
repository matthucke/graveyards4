require 'spec_helper'

describe "graveyards/edit" do
  before(:each) do
    @graveyard = assign(:graveyard, stub_model(Graveyard,
      :feature_type => 1,
      :county => nil,
      :status => 1,
      :name => "MyString",
      :path => "MyString",
      :lat => "9.99",
      :lng => "9.99",
      :year_started => 1,
      :usgs_id => 1,
      :usgs_map => "MyString",
      :homepage => "MyString"
    ))
  end

  it "renders the edit graveyard form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", graveyard_path(@graveyard), "post" do
      assert_select "input#graveyard_feature_type[name=?]", "graveyard[feature_type]"
      assert_select "input#graveyard_county[name=?]", "graveyard[county]"
      assert_select "input#graveyard_status[name=?]", "graveyard[status]"
      assert_select "input#graveyard_name[name=?]", "graveyard[name]"
      assert_select "input#graveyard_path[name=?]", "graveyard[path]"
      assert_select "input#graveyard_lat[name=?]", "graveyard[lat]"
      assert_select "input#graveyard_lng[name=?]", "graveyard[lng]"
      assert_select "input#graveyard_year_started[name=?]", "graveyard[year_started]"
      assert_select "input#graveyard_usgs_id[name=?]", "graveyard[usgs_id]"
      assert_select "input#graveyard_usgs_map[name=?]", "graveyard[usgs_map]"
      assert_select "input#graveyard_homepage[name=?]", "graveyard[homepage]"
    end
  end
end

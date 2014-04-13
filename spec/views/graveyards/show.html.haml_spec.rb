require 'spec_helper'

describe "graveyards/show" do
  before(:each) do
    @graveyard = assign(:graveyard, stub_model(Graveyard,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(//)
    rendered.should match(/2/)
    rendered.should match(/Name/)
    rendered.should match(/Path/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/Usgs Map/)
    rendered.should match(/Homepage/)
  end
end

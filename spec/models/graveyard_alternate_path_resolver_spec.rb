require 'spec_helper'

describe GraveyardAlternatePathResolver do
  before(:all) {
    CountyPathIndex.reset!
    Graveyard.delete_all
    @graveyard =  create(:graveyard, county: create(:klendathu), name: "Saint Jimmy's Cemetery")
  }

#   {"controller"=>"graveyards", "action"=>"show", "state_path"=>"Illinois", "county_path"=>"Will", "graveyard_path"=>"Bronson"}

  context "find graveyard with missing suffix" do
    subject { GraveyardAlternatePathResolver.from_path("Illinois/Klendathu/Saint-Jimmys") }

    its(:county_path) { should == 'Klendathu' }
    its(:state_path) { should == 'Illinois' }
    its(:graveyard_path) { should == 'Saint-Jimmys' }
    its(:graveyard) { should == @graveyard }
    its(:full_path) { should =="Illinois/Klendathu/Saint-Jimmys" }
  end

  context "find via state alias" do
    subject { GraveyardAlternatePathResolver.from_path("IL/Klendathu/Saint-Jimmys") }
    its(:county_id) { should == @graveyard.county_id}
    its(:graveyard) { should == @graveyard }
  end

end

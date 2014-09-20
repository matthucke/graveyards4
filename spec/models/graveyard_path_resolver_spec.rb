require 'spec_helper'

describe GraveyardPathResolver do
  before(:each) { CountyPathIndex.reset! }

#   {"controller"=>"graveyards", "action"=>"show", "state_path"=>"Illinois", "county_path"=>"Will", "graveyard_path"=>"Bronson"}

  context "class methods" do
    let(:graveyard) { create(:graveyard, county: create(:klendathu), name: "Saint Wolf's Cemetery") }

    subject { GraveyardPathResolver }

    it "extracts path params from graveyard" do
      path_params = subject.params_from(graveyard)

      expect(path_params).to be == {
          :state_path=>"Illinois",
          :county_path=>"Klendathu",
          :graveyard_path=>"Saint-Wolfs-Cemetery",
          :extra_path=>nil
      }
      #  full_path: "Illinois/Klendathu/Saint-Wolfs-Cemetery"

    end
  end

  context "find a graveyard" do
    let(:graveyard) { create(:graveyard, county: create(:klendathu), name: "Saint Wolf's Cemetery") }
    subject { GraveyardPathResolver.from_path(graveyard.full_path) }

    its(:county_path) { should == 'Klendathu' }
    its(:state_path) { should == 'Illinois' }
    its(:graveyard_path) { should == 'Saint-Wolfs-Cemetery' }
    its(:full_path) { should == graveyard.full_path }
    its(:graveyard) { should == graveyard }
  end

  context "find via county" do
    let(:graveyard) { create(:graveyard, county: create(:klendathu), name: "Saint Wolf's Cemetery") }
    subject { GraveyardPathResolver.from_path(graveyard.full_path) }
    its(:county_id) { should == graveyard.county_id}
  end

end

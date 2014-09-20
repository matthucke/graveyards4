require 'spec_helper'

describe ShowGraveyard do
  context "happy path" do
    let(:graveyard) { create(:graveyard, county: create(:klendathu), name: "Oak Ridge Cemetery") }
    let(:params) { ActionController::Parameters.new( GraveyardPathResolver.params_from(graveyard) ) }
    let(:subject) { ShowGraveyard.new(params: params) }

    its(:graveyard) { should be == graveyard }
    its(:redirect?) { should be_false }
  end

  context "sloppy path" do
    let(:graveyard) { create(:graveyard, county: create(:klendathu), name: "Oak Ridge Cemetery") }
    let(:params) { ActionController::Parameters.new(
        :state_path => 'Illinois',
        :county_path => 'Klendathu',
        :graveyard_path => 'Oak-Ridge'
    ) }
    let(:subject) { ShowGraveyard.new(params: params) }

    its(:graveyard) { should be == graveyard }
    its(:redirect?) { should be_true }

  end
end

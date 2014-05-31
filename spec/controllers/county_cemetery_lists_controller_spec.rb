require 'spec_helper'

# CountyCemeteryList is not an actual model.
# This is just a set of alternate views on County.
describe CountyCemeteryListsController do

  let(:valid_attributes) { {
      name: "Gondwana",
      state: FactoryGirl.create(:illinois) }
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "has no index" do
      # get :index, {}, valid_session
      # expect(response.status).to eq 302
      # expect(response).to redirect_to '/graveyards'
    end
  end

  describe "GET show" do
    it "assigns the requested county as @county" do
      county = County.create! valid_attributes
      get :show, {:state => county.state.path, :county=>county.path}, valid_session
      expect(request.path).to be == '/Illinois/Gondwana/list'
      expect(assigns :county).to be == county
    end
  end

  describe "GET a 404" do
    it "returns 404 when no good" do
      get :show, {:state => 'IL', :county=>'Alfred'}, valid_session
      expect(assigns :county).to be == nil
      expect(response.status).to eq 404
    end
  end


end

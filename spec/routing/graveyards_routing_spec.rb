require "spec_helper"

describe GraveyardsController do
  describe "routing" do

    it "routes to #index" do
      get("/graveyards").should route_to("graveyards#index")
    end

    it "routes to #new" do
      get("/graveyards/new").should route_to("graveyards#new")
    end

    it "routes to #show" do
      get("/graveyards/1").should route_to("graveyards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/graveyards/1/edit").should route_to("graveyards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/graveyards").should route_to("graveyards#create")
    end

    it "routes to #update" do
      put("/graveyards/1").should route_to("graveyards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/graveyards/1").should route_to("graveyards#destroy", :id => "1")
    end

  end
end

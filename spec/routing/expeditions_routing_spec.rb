require "spec_helper"

describe ExpeditionsController do
  describe "routing" do

    it "routes to #index" do
      get("/expeditions").should route_to("expeditions#index")
    end

    it "routes to #new" do
      get("/expeditions/new").should route_to("expeditions#new")
    end

    it "routes to #show" do
      get("/expeditions/1").should route_to("expeditions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/expeditions/1/edit").should route_to("expeditions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/expeditions").should route_to("expeditions#create")
    end

    it "routes to #update" do
      put("/expeditions/1").should route_to("expeditions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/expeditions/1").should route_to("expeditions#destroy", :id => "1")
    end

  end
end

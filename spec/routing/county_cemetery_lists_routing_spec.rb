require "spec_helper"

describe CountyCemeteryListsController do
  describe "routing" do

    it "routes to #index" do
      get("/county_cemetery_lists").should route_to("county_cemetery_lists#index")
    end

    it "routes to #new" do
      get("/county_cemetery_lists/new").should route_to("county_cemetery_lists#new")
    end

    it "routes to #show" do
      get("/county_cemetery_lists/1").should route_to("county_cemetery_lists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/county_cemetery_lists/1/edit").should route_to("county_cemetery_lists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/county_cemetery_lists").should route_to("county_cemetery_lists#create")
    end

    it "routes to #update" do
      put("/county_cemetery_lists/1").should route_to("county_cemetery_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/county_cemetery_lists/1").should route_to("county_cemetery_lists#destroy", :id => "1")
    end

  end
end

require "spec_helper"

describe CountiesController do
  describe "routing" do

    it "routes to #index" do
      get("/counties").should route_to("counties#index")
    end

    it "routes to #new" do
      get("/counties/new").should route_to("counties#new")
    end

    it "routes to #show" do
      get("/counties/1").should route_to("counties#show", :id => "1")
    end

    it "routes to #edit" do
      get("/counties/1/edit").should route_to("counties#edit", :id => "1")
    end

    it "routes to #create" do
      post("/counties").should route_to("counties#create")
    end

    it "routes to #update" do
      put("/counties/1").should route_to("counties#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/counties/1").should route_to("counties#destroy", :id => "1")
    end

  end
end

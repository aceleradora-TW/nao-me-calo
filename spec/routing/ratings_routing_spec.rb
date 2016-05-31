require "rails_helper"

RSpec.describe RatingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ratings").to route_to("ratings#index")
    end

    it "routes to #new" do
      expect(:get => "/ratings/new").to route_to("ratings#new")
    end

    it "routes to #show" do
      expect(:get => "/ratings/1").to route_to("ratings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ratings/1/edit").to route_to("ratings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ratings").to route_to("ratings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ratings/1").to route_to("ratings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ratings/1").to route_to("ratings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ratings/1").to route_to("ratings#destroy", :id => "1")
    end

  end
end

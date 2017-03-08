require "rails_helper"

RSpec.describe SponsoredPostsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sponsored_posts").to route_to("sponsored_posts#index")
    end

    it "routes to #new" do
      expect(:get => "/sponsored_posts/new").to route_to("sponsored_posts#new")
    end

    it "routes to #show" do
      expect(:get => "/sponsored_posts/1").to route_to("sponsored_posts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sponsored_posts/1/edit").to route_to("sponsored_posts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sponsored_posts").to route_to("sponsored_posts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sponsored_posts/1").to route_to("sponsored_posts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sponsored_posts/1").to route_to("sponsored_posts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sponsored_posts/1").to route_to("sponsored_posts#destroy", :id => "1")
    end

  end
end

require "rails_helper"

RSpec.describe DashboardsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/").to route_to("dashboards#index")
    end
  end
end

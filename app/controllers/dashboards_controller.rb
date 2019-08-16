class DashboardsController < ApplicationController

  # GET /dashboards
  # GET /dashboards.json
  def index
    @athletes = User.all
  end
end

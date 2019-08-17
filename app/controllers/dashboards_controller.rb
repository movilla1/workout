class DashboardsController < ApplicationController

  # GET /dashboards
  # GET /dashboards.json
  def index
    @athletes = User.paginate(page: params[:page])
  end
end

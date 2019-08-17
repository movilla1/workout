class DashboardsController < ApplicationController

  # GET /dashboards
  # GET /dashboards.json
  def index
    @athletes = User.paginate(page: params[:page])
  end

  def search
    @athletes = User
      .paginate(page: params[:page])
      .where('first_name LIKE :keywords OR last_name LIKE :keywords
        OR email LIKE :keywords', keywords: "%#{params[:keywords]}%")
    flash[:notice] = "No user found with the requested details" if @athletes.count <= 0
    render :index
  end
end

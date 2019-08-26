class ApplicationController < ActionController::Base
  def current_room
    @room ||= Room.find(session[:current_room]) if session[:current_room].present?
  end

  helper_method :current_room
end

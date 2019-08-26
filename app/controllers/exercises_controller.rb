# Class for exercises
class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :destroy, :edit, :update, :destroy]
  before_action :set_current_room

  def index
    @exercises = current_user.exercises
    @friends = current_user.friends
    @message = Message.new
    @messages = current_user.messages if current_room
    @followers = Friendship.where(friend_id: current_user.id)
  end

  def edit
    @user = current_user
  end

  def show; end

  def new
    @user = current_user
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params.merge(user_id: current_user.id))
    if @exercise.save
      redirect_to user_exercise_path(current_user, @exercise), notice: "Exercise has been created"
    else
      @user = current_user
      flash[:error] = "Exercise has failed to save"
      render :new
    end
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to user_exercise_path(current_user, @exercise), notice: "Exercise Updated Successfully"
    else
      @user = current_user
      render :edit, error: "Failed to update"
    end
  end

  def destroy
    if @exercise.destroy
      flash[:notice] = "Exercise Deleted Successfully"
    else
      flash[:error] = "Failed to delete Exercise"
    end
    redirect_to user_exercises_path(current_user)
  end

  private

  def exercise_params
    params.require(:exercise).permit(:workout, :workout_date, :duration_in_minutes)
  end

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def set_current_room
    @room = params[:room_id].present? ?  Room.find(params[:room_id]) : current_user.room
    session[:current_room] = @room.id if @room.present?
  end
end

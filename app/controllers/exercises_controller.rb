# Class for exercises
class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :destroy, :edit]

  def index; end
  def edit; end
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

  private

  def exercise_params
    params.require(:exercise).permit(:workout, :workout_date, :duration_in_minutes)
  end

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end
end

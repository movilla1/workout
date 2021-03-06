class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def show
    @friend = Friendship.find(params[:id]).friend
    @exercises = @friend.exercises
  end

  def create
    unless current_user.follows_or_same?(params[:friend_id])
      Friendship
        .create!(friend_id: params[:friend_id], user_id: current_user.id)
    end
    redirect_to root_path
  end

  def destroy
    friendship = Friendship.find(params[:id])
    if friendship.destroy 
      flash[:notice] = "#{friendship.friend.full_name} unfollowed"
    else
      flash[:alert] = "Couln't unfollow #{friendship.friend.full_name}"
    end
    redirect_to user_exercises_path(current_user)
  end

  private

  def friendships_params
    params.permit(:friend_id, :user_id)
  end
end

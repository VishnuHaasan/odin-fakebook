class FriendsController < ApplicationController
  def destroy
    @friend = User.find(params[:id])
    Friendship.find(user_id: current_user.id, friend_id: @friend.id).destroy
    Friendship.find(user_id: @friend.id, friend_id: current_user.id).destroy
    redirect_back(fallback_location: root_path)
  end
end

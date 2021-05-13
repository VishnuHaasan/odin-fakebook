class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    ids = current_user.sent_requests.map{|req| req.receiver_id}
    @users = User.all.select{|user| !current_user.friends.include?(user) && current_user!=user && !ids.include?(user.id)}

    unless params[:requested_user].nil?
      receiver = User.find(params[:requested_user])
      create_request(current_user, receiver)
      redirect_to "/users"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private
    def create_request(user, receiver)
      request = check_both_way(user, receiver)
      if request!="No"
        request.accept
        flash[:notice] = "You have become friends because of mutual requests!"
      else
        user.sent_requests.create(receiver_id: receiver.id)
        flash[:notice] = "Friend request sent!"
      end 

    end

    def check_both_way(user, receiver)
      receiver.sent_requests.each do |req|
        if req.receiver_id == user.id
          return req
        end
      end
      return "No"
    end
end
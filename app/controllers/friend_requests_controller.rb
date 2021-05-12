class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  def index
    @requests = current_user.received_requests

    @sent_requests = current_user.sent_requests

    unless params[:request].nil? && params[:commit].nil?
      request = FriendRequest.find(params[:request])
      request_handler(request, params[:commit])
      redirect_to friend_requests_path
    end
  end

  def destroy
    @request = FriendRequest.find(params[:id])
    @request.destroy
    redirect_to friend_requests_path
  end

  private
    def request_handler(request, commit)  
      if commit == "Accept"
        request.accept
        flash[:notice] = "Request accepted!"
      elsif commit == "Decline"
        request.decline
        flash[:notice] = "Request declined!"
      end
    end
end

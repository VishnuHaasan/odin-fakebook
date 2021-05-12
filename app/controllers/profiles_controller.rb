class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      flash[:notice] = "Profile Created successfully"
      redirect_to profile_path(@profile)
    else
      flash.now[:alert] = "Information insufficient for profile creation"
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:notice] = "Profile updated successfully"
      redirect_to profile_path(@profile)
    else
      flash.now[:alert] = "Information insufficient for profile updation"
      render :edit
    end 
  end

  def show
    @profile = Profile.find(params[:id])
    user  = @profile.user
    @friends = current_user.friends
    if current_user!=@profile.user
      @friends =  friends.select{|f| user.friends.include?(f)}
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:dname, :dpicture, :age, :bio)
    end
end

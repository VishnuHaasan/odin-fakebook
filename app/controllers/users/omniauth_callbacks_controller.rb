class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :verify_authenticity_token, only: :facebook

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else  
      session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registeration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
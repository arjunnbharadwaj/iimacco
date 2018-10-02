class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    login_omniauth(request.env["omniauth.auth"])
  end

  def failure
    redirect_to root_path
  end

  private
    def login_omniauth(omniauth_info)
      @user = User.from_omniauth(omniauth_info)

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
      else
        redirect_to root_path
      end
    end
end
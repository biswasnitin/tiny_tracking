class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

    private
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]

  end

  def redirect_to_login
    if current_user.blank?
      redirect_to "/login"
    end

  end
end

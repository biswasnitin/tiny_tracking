class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:email],params[:password])
    if user
      cookies[:auth_token] = user.auth_token
      redirect_to user_track_logs_path,:notice => "Logged in!"
    else

      flash[:error] = "Invalid email or password"
      render 'new'
    end

  end

  def destroy
    #    session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to root_url,:notice => "Logged out!"
  end
end

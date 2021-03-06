class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.where(provider: auth["provider"], uid: auth["uid"]).first
    user = User.create_omni auth if user.nil?
    session[:user_id] = user.id

    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_url
  end
end
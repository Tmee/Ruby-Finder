class SessionsController < ApplicationController

  def create
    user = User.find_or_create_by_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to search_path
  end

  def destroy
    session.clear
    redirect_to search_path
  end
end

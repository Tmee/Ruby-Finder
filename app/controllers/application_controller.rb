class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :no_notes?, :most_recent_notes

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def no_notes?
    current_user.notes.empty?
  end

  def most_recent_notes
    current_user.notes.order("updated_at").last(3)
  end
end

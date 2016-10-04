class Web::ApplicationController < ApplicationController
  helper_method :current_user

  def current_user
    @current_user ||= ::User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    redirect_to tasks_path unless current_user
  end
end

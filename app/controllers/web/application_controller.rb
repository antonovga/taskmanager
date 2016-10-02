class Web::ApplicationController < ApplicationController
  before_action :authenticate

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    redirect_to new_auth_session_path unless current_user
  end
end

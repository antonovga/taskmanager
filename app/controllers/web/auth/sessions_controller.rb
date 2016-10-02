class Web::Auth::SessionsController < Web::ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
    @session = Session.new
    redirect_to root_path if current_user
  end

  def create
    user = User.find_by_email(session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to new_auth_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_auth_session_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end

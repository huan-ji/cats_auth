class SessionsController < ApplicationController
  before_action only:[:new, :create] do
    redirect_to cats_url if current_user
  end

  def new

  end

  def create
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

    if user
      user.reset_session_token!
      session[:session_token] = user.session_token
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end
    redirect_to new_session_url
  end

end

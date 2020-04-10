class LoginsController < ApplicationController
  skip_before_action :set_mode

  def show
    if session[:logged_in]
      render :logout
      return
    end
  end

  def create
    if ENV["FUTURE_AGE_USER_PASSWORD"].present?
      if params[:password] == ENV["FUTURE_AGE_USER_PASSWORD"]
        session[:logged_in] = true
        redirect_to root_url
        return
      end
    end
    render :show
  end

  def destroy
    session.delete(:logged_in)
    redirect_to root_url
  end
end

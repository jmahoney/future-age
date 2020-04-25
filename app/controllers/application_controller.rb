class ApplicationController < ActionController::Base
  before_action :set_mode

  @public_mode = true

  def set_mode
    unless session[:logged_in]
      session[:logged_in] = cookies[:logged_in]
    end
    @public_mode = session[:logged_in] ? false : true
  end
end

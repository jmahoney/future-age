class ApplicationController < ActionController::Base
  before_action :set_mode

  @public_mode = true

  def set_mode
    @public_mode = session[:logged_in] ? false : true
  end
end

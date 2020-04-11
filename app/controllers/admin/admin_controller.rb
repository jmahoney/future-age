class Admin::AdminController < ApplicationController
  before_action :check_mode

  def check_mode
    if @public_mode
      redirect_to root_url
    end
  end
end
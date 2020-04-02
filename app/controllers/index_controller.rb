class IndexController < ApplicationController
  def index
    @items = Item.includes(:feed).where(read: false).order(Updated_at: :desc).limit(30)
  end
end

class IndexController < ApplicationController
  def index
    @items = Item.includes(:feed).where(read: false).order(published_date: :desc).limit(30)
  end
end

class IndexController < ApplicationController
  def index
    @items = Item.includes(:feed).where(read: false).order(date_published: :desc).limit(10)
  end
end

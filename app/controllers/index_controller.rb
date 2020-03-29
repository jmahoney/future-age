class IndexController < ApplicationController
  def index
    @items = Item.includes(:feed).where(read: false).order(date_published: :desc).limit(30)
  end
end

class ItemsController < ApplicationController
  def index
    @items = Item.includes(:feed).where(read: false).order(date_published: :desc).limit(30)
  end

  private

  def item_params
    params.require(:item).permit(:feed_id, :read, :starred)
  end
end

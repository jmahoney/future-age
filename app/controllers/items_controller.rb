class ItemsController < ApplicationController
  before_action :set_item, only: [:toggle_item]


  def index
    @items = Item.includes(:feed).where(read: false).order(date_published: :desc).limit(30)
  end

  def toggle_starred
    respond_to do |format|
      if @item.toggle_starred
        format.json { render :starred, status: :ok, location: @item }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:feed_id, :read, :starred)
  end
end

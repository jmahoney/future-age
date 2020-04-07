class ItemsController < ApplicationController
  def index
    @items = Item.includes(:feed).where(read: false).order(date_published: :desc).limit(30)
  end

  def toggle_starred
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.toggle_starred
        format.json { render :show, status: :ok}
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

end

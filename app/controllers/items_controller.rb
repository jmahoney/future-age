class ItemsController < ApplicationController
  before_action :set_item, only: [:toggle_starred, :update]

  def index
    @items = Item.includes(:feed)
                .where("date_published < ?", start_date(params[:s]))
                .where(read: false)
                .order(date_published: :desc).limit(30)
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.json { render :show, status: :ok}
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_starred
    respond_to do |format|
      if @item.toggle_starred
        format.json { render :show, status: :ok}
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:read)
    end

    def start_date(d)
      return DateTime.now.utc if d.nil?

      begin
        return DateTime.parse(d)
      rescue => exception
        return DateTime.now.utc
      end
    end

end

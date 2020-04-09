class ItemsController < ApplicationController
  def index
    @items = Item.includes(:feed)
                .where("date_published < ?", start_date(params[:s]))
                .where(read: false)
                .order(date_published: :desc).limit(3)
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

  private
  def start_date(d)
    return DateTime.now.utc if d.nil?

    begin
      return DateTime.parse(d)
    rescue => exception
      return DateTime.now.utc
    end
  end

end

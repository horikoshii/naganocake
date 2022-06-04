class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    @item = Item.new
    @item.save
    redirect_to items_path(item.id)
  end

  def index
    @item = Item.all
  end

  def show
    @item = Item.find(item_params)
  end

  private

  def item_params
    params.require(:items).permit(:name, :image, :price,:introduction,:genre_id,:is_active)
  end
end

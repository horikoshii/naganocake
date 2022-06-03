class Admin::ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end
  
  def index
    @item = Item.all
  end
  
end

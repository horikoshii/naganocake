class Customer::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items.all
  end

  def update
    @item = Item.find(params[:id])
    @item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end
  
  def destroy_all
   current_customer.cart_items.destroy_all
   redirect_to cart_items_path
  end

   private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
class Customer::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end

  def orders_comfirm
    @cart_items = current_customer.cart_items.all
  end
end

class Customer::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @subtotal = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price } + 800
  end

  def comfirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_number] == "2"
      address = Address.find_by(params[:address_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    elsif params[:order][:address_number] == "3"
      @order.postal_code = Address.new
      @order.address = Address.new
      @order.name = Address.new
    end
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @subtotal = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price } + 800
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.order.new(order_params)
    if @order.save
      cart_items.each do |cart_item|
        order = Order.new
        order.item_id = cart_item.item_id
        order.order_id = @order.id
        order.order_amount = cart_item.amount
        order.order_price = cart_item.item.price
        order.save
      end
       redirect_to orders_complete_path
       cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end

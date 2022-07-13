class Customer::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
  end

  def index
    @orders = current_customer.order.all
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
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    redirect_to orders_comfirm_path
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end

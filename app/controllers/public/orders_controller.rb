class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.where(customer: current_customer)
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)

    if params[:order][:addresses] == "address"
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.address
      @order.name        = current_customer.last_name + current_customer.first_name

    elsif params[:order][:addresses] == "addresses"
      addresses = Address.find(params[:order][:addresses_id])
      @order.postal_code = addresses.postal_code
      @order.address     = addresses.address
      @order.name        = addresses.name

    elsif params[:order][:addresses] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.address     = params[:order][:address]
      @order.name        = params[:order][:name]
      @addresses = "1"
    end
  end

  def create
    order = Order.new(order_params)
    order.save
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order=Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_fee, :price, :status)
  end

  def addresses_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
end

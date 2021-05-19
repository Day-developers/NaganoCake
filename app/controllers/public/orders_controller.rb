class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.all
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new
  end

  def create
    order = Order.new(order_params)
    order.save
  end

  def complete
    
  def index
    @orders = current_customer.orders
  end

  def show
    @order=Order.find(params[:id])
  end
end

class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.all
  end

  def index
  end

  def show
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
  end
end

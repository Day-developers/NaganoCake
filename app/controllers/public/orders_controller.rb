class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
  end

  def create
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order=Order.find(params[:id])
  end
end

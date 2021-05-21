class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses
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
      if params[:order][:postal_code] != "" && params[:order][:address] != "" && params[:order][:name] != ""
        @order.postal_code = params[:order][:postal_code]
        @order.address     = params[:order][:address]
        @order.name        = params[:order][:name]
        @addresses = "1"
      else
        flash[:danger] = "新しいお届け先が入力されていません"
        redirect_to new_order_path
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_fee = 800
    @order.status = 0

    if @order.save
      flash[:success] = "ご注文が確定しました。"
      current_customer.cart_items.each do |cart_item|
        order_item = OrderItem.new
        order_item.number = cart_item.number
        order_item.price = cart_item.item.price
        order_item.order_id = @order.id
        order_item.item_id = cart_item.item_id
        order_item.save
      end

      if params[:order][:addresses] == "1"
        current_customer.addresses.create(address_params)
      end

      current_customer.cart_items.destroy_all
      redirect_to orders_complete_path
    else
      @order = Order.new
      @addresses = current_customer.addresses
      render 'new'
    end
  end

  def complete
  end

  def index
    @orders = current_customer.orders
    @orders = Order.where(customer_id: current_customer.id).order("created_at DESC")
  end

  def show
    @order=Order.find(params[:id])
    @order_items = @order.order_items
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :payment_amount )
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
end

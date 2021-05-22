class Admin::OrdersController < ApplicationController
  def show
    @order=Order.find(params[:id])
    @customer=Customer.find_by(id: @order.customer_id)
    @order_item=OrderItem.where(order_id: @order.id)
  end

  def update
    @order=Order.find(params[:id])
    @order_item=OrderItem.where(order_id: @order.id)
    if @order.update(order_params)
      if @order.status == "入金確認"
        @order_item.update(making_status: 1)
        redirect_to admin_order_path(@order.id)
      else
        redirect_to admin_order_path(@order.id)
      end
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

end

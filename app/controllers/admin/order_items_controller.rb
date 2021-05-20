class Admin::OrderItemsController < ApplicationController
  def update
    @order=Order.find(params[:id])
    @order_item=OrderItem.find(params[:order_id])
    @order_item.update(order_item_params)
    redirect_to admin_order_path(@order.id)
  end

  def order_item_params
    params.require(:order_item).permit(:making_status)
  end


end
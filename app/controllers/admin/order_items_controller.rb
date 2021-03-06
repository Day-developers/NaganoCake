class Admin::OrderItemsController < ApplicationController
  def update
    @order=Order.find(params[:id])
    @order_item=OrderItem.find(params[:order_id])

    if @order_item.update(order_item_params)
      if @order_item.making_status == "製作中"
        @order.update(status: 2)
        render :show
      elsif @order.order_items.where(making_status: "製作完了").count == @order.order_items.count
        @order.update(status: 3)
        render :show
      else
        render :show
      end
    end
  end

  def order_item_params
    params.require(:order_item).permit(:making_status)
  end


end
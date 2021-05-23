class Admin::OrdersController < ApplicationController
  def show
    @order=Order.find(params[:id])
    @customer=Customer.find_by(id: @order.customer_id)
    @order_items=OrderItem.where(order_id: @order.id)
  end

  def update
    @order=Order.find(params[:id])
    @order_items=OrderItem.where(order_id: @order.id)
    
    if @order.update(order_params)
      if @order.status == "入金確認"
        @order_items.update(making_status: 1)
        render :show
      else
        render :show
      end
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

end

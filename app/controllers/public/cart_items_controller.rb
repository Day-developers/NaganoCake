class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_item = CartItem.where(customer_id: current_customer.id)
  end

  def create
    if @cart_item_new.blank?
      @cart_item_new = current_customer.cart_items.build(item_id: params[:item_id])
      @cart_item_new.save
      redirect_to cart_items_path
    else
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.number += params[:number].to_i
      if @cart_item.save
        flash[:success] = "カートに追加しました"
        redirect_to cart_items_path
      else
        flash[:danger] = "エラーが発生しました"
        redirect_to request.referer
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
  　   redirect_to cart_items_path
  　else
      flash[:danger] = "正しい個数を入力してください"
      redirect_to request.referer
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:success] = "選択いただいた商品を削除しました"
    redirect_to cart_items_path
  end

  def destroy_all
   @cart_items = current_customer.cart_items.all
   @cart_items.destroy_all
   flash[:success] = "カートの中身を空にしました"
   redirect_to cart_items_path
  end


  private

    def cart_item_params
      params.require(:cart_item).permit(:item_id, :number)
    end

end

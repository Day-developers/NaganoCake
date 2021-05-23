class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_item = CartItem.where(customer_id: current_customer.id).order("created_at DESC")
  end

  def create
    @cart_items = CartItem.find_by(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])
    if @cart_items.present?
      @cart_items.number += params[:cart_item][:number].to_i
      @cart_items.save
      flash[:success] = "カートに追加しました"
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        flash[:success] = "カートに追加しました"
        redirect_to cart_items_path
      else
        flash[:danger] = "個数を入力してください"
        redirect_to item_path(@cart_item.item)
      end
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_items = CartItem.where(customer_id: current_customer.id).order("created_at DESC")
    if @cart_item.update(cart_item_params)
      render :index
    else
      flash[:danger] = "正しい個数を入力してください"
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_items = CartItem.where(customer_id: current_customer.id).order("created_at DESC")
    @cart_item.destroy
    flash[:success] = "選択いただいた商品を削除しました"
    render :index
  end

  def destroy_all
   @cart_items = current_customer.cart_items.all
   @cart_items.destroy_all
   render :index
  end


  private

    def cart_item_params
      params.require(:cart_item).permit(:item_id, :number)
    end

end

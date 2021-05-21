class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(8).order("created_at DESC")
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end

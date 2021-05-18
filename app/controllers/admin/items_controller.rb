class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_items, only: [:new, :create, :edit, :update]

  def new
    @item = Item.new

  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render 'new'
    end
  end

  def index
    @items = Item.all.page(params[:page]).reverse_order
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render 'edit'
    end
  end

  def set_items
    @item = Item.all
  end

  private
  def item_params
    params.require(:item).permit(:name, :image, :caption,
       :genre_id, :price, :is_active)
  end
end

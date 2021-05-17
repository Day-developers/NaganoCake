class Admin::ItemsController < ApplicationController
  def new
  end

  def index
    @items = Item.all.page(params[:page]).reverse_order
  end

  def show
  end

  def edit
  end
end

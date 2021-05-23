class Public::SearchesController < ApplicationController

  def search
    @items = Item.looks(params[:search]).page(params[:page]).per(10)
  end
end

class Admin::SearchesController < ApplicationController
  def search
    @items = Item.looks(params[:search]).page(params[:page]).per(5)
    @customers = Customer.looks(params[:search]).page(params[:page]).per(5)
  end
end

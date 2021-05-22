class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @addresses = Address.all
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @addresses = current_customer.addresses
    if @address.save
      flash[:success] = "配送先を追加しました"
      # redirect_to addresses_path
    else
      render 'index'
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:success] = "配送先情報を変更しました"
      redirect_to addresses_path(@address)
    else
      render 'edit'
    end
  end

  def destroy
    @addresses = Address.all
    @address = Address.find(params[:id])
    @address.destroy
    flash[:success] = "配送先を削除しました"
    # redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end

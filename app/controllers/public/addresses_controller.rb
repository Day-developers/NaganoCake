class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @addresses = current_customer.addresses
    respond_to do |format|
      if @address.save
        format.js { flash[:success] = "配送先を追加しました" }
      else
        render 'index'
      end
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
    @addresses = current_customer.addresses
    @address = Address.find(params[:id])
    @address.destroy
    respond_to do |format|
      format.js { flash[:success] = "配送先を削除しました" }
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end

class Admin::CustomersController < ApplicationController
  def index
    @customers=Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer=Customer.find(params[:id])
  end

  def edit
    @customer=Customer.find(params[:id])
  end

  def update
    @customer=Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(params[:id])
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :address, :phone_number, :email, :is_deleted)
  end

end

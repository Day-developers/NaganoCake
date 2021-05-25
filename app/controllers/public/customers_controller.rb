class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:show, :edit, :update, :unsubscribe, :withdraw]
  
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:success] = "会員情報を更新しました"
      redirect_to customers_my_page_path
    else
      render 'edit'
    end
  end
  
  def unsubscribe
    @customer = current_customer
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:success] = "退会処理が完了しました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :address, :phone_number, :email)
  end
end

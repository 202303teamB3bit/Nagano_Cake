class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報が更新されました"
      redirect_to admin_customer_path(@customer)
    else
      flash[:alert] = "会員情報の更新に失敗しました"
      render :edit
    end
  end

  def orders
    @customer = Customer.find(params[:id])
    @orders = @customer.orders.page(params[:page])
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana,
                   :post_code, :address, :phone_number, :email, :is_deleted)
  end
end

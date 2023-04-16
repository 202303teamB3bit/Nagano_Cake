class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customers_params)
      flash[:notice] = "会員情報を変更いたしました"
      redirect_to customers_my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
  end


  private

  def customers_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :post_code, :address, :phone_number)
  end

end

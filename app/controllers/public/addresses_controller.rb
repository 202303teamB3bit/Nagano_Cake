class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer
    @addresses = @customer.addresses.page(params[:page])
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "配送先を追加しました"
      redirect_to request.referer
    else
      @customer = current_customer
      @addresses = @customer.addresses.page(params[:page])
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "配送先を編集しました"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:alert] = "配送先を削除しました"
    redirect_to request.referer
  end

  private

  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end

end

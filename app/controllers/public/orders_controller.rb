class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to orders_path, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def index
  end

  def show
  end

  def check
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:name, :post_code,
                                  :address, :payment_method)
  end

end

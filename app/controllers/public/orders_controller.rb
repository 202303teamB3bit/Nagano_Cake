class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      redirect_to complete_orders_path, notice: 'Thanks!!!'
    else
      flash[:alert] = '注文情報が正しく送信されませんでした。もう一度お試しください。'
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
    @total = 0
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:name, :post_code,
                                  :address, :payment_method,
                                  :shipping_fee, :billing_amont,)
  end

end

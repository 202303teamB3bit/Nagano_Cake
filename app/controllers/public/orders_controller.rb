class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @addresses = current_customer.addresses

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

    if params[:order][:address_option] == "0"
      @order.ship_postcode = current_customer.postcode
      @order.ship_address = current_customer.address
      @order.ship_name = current_customer.first_name + current_customer.last_name

      elsif params[:order][:address_option] == "1"
        ship = Destination.find(params[:order][:customer_id])
        @order.ship_postcode = ship.postcode
        @order.ship_address = ship.address
        @order.ship_name = ship.name

        elsif params[:order][:address_option] == "2"
          @order.ship_postcode = params[:order][:ship_postcode]
          @order.ship_address = params[:order][:ship_address]
          @order.ship_name = params[:order][:ship_name]

        else
          @order = Order.new(order_params)
          render :new
        end
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:name, :post_code,
                                  :address, :payment_method,
                                  :shipping_fee, :billing_amont)
 end
 end
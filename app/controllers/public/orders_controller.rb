class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @addresses = current_customer.addresses
    @cart = current_customer.cart_items
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id

    if  @order.customer.cart_items.count >= 1
        @order.save
        current_customer.cart_items.each do |cart_item| #カートの商品を1つずつ取り出しループ
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.quantity = cart_item.quantity
        @order_detail.purchase_price = (cart_item.item.with_tax_price).round
        @order_detail.order_id =  @order.id #注文商品に注文idを紐付け
        @order_detail.making_status = 0
        @order_detail.save
        end
      current_customer.cart_items.destroy_all #カートの中身を削除
    end

    if @order.save
      redirect_to complete_orders_path, notice: 'Thanks!!!'
    else
      flash[:alert] = '注文情報が正しく送信されませんでした。もう一度お試しください。'
      render :new
    end
  end

  def index
    @orders = current_customer.orders

  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all

  end

  def check
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @total = 0

    if params[:order][:address_option] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name

    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:address])
      @order.post_code = ship.post_code
      @order.address = ship.address
      @order.name = ship.name

    elsif params[:order][:address_option] == "2"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]

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
                                  :shipping_fee, :billing_amont,
                                  :customer_id, :status)
  end
end

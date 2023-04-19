class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id

     if @order.customer.cart_items.count >= 1
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
     end

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

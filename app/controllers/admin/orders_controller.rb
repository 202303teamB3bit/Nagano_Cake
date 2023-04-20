class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
  end

  def update
    order = Order.find(params[:id])
    order_details = order.order_details

    #if order.update(order_params)
    #   order_details.update_all(making_status: 1) if order.status == "payment_confirmation"
    # end

    order.update(order_params)
    if order.status == "payment_confirmation"
      order_details.update_all(making_status: 1)
    end

    flash[:notice] = "注文ステータスを変更しました"
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end

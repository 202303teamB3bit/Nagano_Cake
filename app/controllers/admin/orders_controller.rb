class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    flash[:notice] = "注文ステータスを変更しました"
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end

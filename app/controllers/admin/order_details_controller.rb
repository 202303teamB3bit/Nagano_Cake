class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    order_detail = OrderDetail.find(params[:id])
    order = order_detail.order
    order_details = order.order_details

    is_updated = true
    if order_detail.update(order_detail_params)
      # 制作ステータスが一つでもmaking「製作中」になると、注文ステータスを「製作中」に更新する。
      order.update(status: 2) if order_detail.making_status == "making"
      # each分で取り出したorder_detailのmaking_statusが全てcompletion「製作完了」になっていない場合、
      # is_updatedをfalseに変える
      order_details.each do |order_detail|
        if order_detail.making_status != "completion"
          is_updated = false
        end
      end
      # is_updatedがtrueの場合、orderのstatusを3「発送準備中に」更新する
      order.update(status: 3) if is_updated
    end
    redirect_to request.referer

  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end

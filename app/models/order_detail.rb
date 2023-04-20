class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  # いるか
  enum making_status: { no_production: 0, waiting_production: 1,
                         in_production: 2, completion_production: 3 }



  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end


  enum making_status: { cannot_start: 0, waiting: 1, making: 2, completion: 3 }

  def subtotal
    purchase_price * quantity
  end

end

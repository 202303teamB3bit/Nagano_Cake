class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  enum making_status: { no_production: 0, waiting_production: 1,
                         in_production: 2, completion_production: 3 }

  def subtotal
    tax_price * quantity
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end

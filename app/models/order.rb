class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, payment_confirmation: 1, making: 2, shipping_preparation: 3, shipped: 4 }

  def delivery
    "〒#{post_code} #{address}"
  end

end

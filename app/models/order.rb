class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details
  
  validates :post_code, presence: true
  validates :name, presence: true
  validates :address, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, payment_confirmation: 1, making: 2, shipping_preparation: 3, shipped: 4 }


  def subtotal
    tax_price * quantity
  end

  def total_price
    order_details.sum { |detail| detail.quantity * detail.purchase_price }
  end

  def delivery
    "〒#{post_code} #{address}"

  end

end

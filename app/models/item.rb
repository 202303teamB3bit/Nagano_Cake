class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  belongs_to :genre

  has_one_attached :image
  enum is_active: { sale: true, discontinued: false }


  validates :name, presence:         true
  validates :introduction, presence: true
  validates :price, presence:        true
  validates :is_active, presence:    true
  validates :genre_id, presence:     true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_fill: [width, height]).processed
  end

  # 単価（税込）
  def with_tax_price
    (price * 1.1).floor
  end

end

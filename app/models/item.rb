class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy, foreign_key: 'item_id'
  has_many :customers, through: :cart_items

  has_one_attached :image
  enum is_active: { sale: true, discontinued: false }
  belongs_to :genre

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_fill: [width, height]).processed
  end


end

class Item < ApplicationRecord

  has_one_attached :image
  enum sales_status: { sale: 0, discontinued: 1 }
  

end

class Genre < ApplicationRecord
  has_many :item
  validates :name, presence: true, uniqueness: true
end

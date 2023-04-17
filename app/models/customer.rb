class Customer < ApplicationRecord

  def full_name
    "#{first_name} #{last_name}"
  end


  # フルネームカナが未定義なので新たに作ってます
  def full_name_kana
    "#{first_name_kana} #{last_name_kana}"
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :addresses, dependent: :destroy
 has_many :cart_items
 has_many :items, through: :cart_items

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :post_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
end

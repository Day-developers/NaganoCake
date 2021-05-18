class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum payment_method: { クレジットカード: 0, 銀行振り込み: 1 }
  enum status: { 入金待ち: 0, 入金確認: 1, 制作中: 2, 発送準備中: 3, 発送済み: 4}

  validates :customer_id, :address, :name, :shipping_fee, :payment_amount, :payment_method, presence: true
  validates :postal_code, presence: true, length: {is: 7}, numericality: { only_integer: true }
  validates :shipping_fee, :payment_amount, numericality: { only_integer: true }

end

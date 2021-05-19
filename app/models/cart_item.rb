class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :number, presence: true
  validates :number, numericality: { only_integer: true }


  def item_price_with_tax
    (item.price*1.10).round
  end

  def sum
    (item.price*1.10*number).round
  end

end

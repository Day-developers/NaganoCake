class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def  amount
    (cart_item.item.price*1.10*cart_item.number).round
  end
end

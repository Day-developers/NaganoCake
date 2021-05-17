class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def  add_tax_sales_price
    (self.sales_price * 1.10).round
  end
end

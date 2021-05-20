class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: {制作不可: 0, 制作待ち: 1, 制作中: 2, 制作完了: 3}

  def tax_price
    (self.price * 1.10).round
  end

end

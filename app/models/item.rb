class Item < ApplicationRecord
    belongs_to :genre
    has_many :cart_items, dependent: :destroy
    has_many :order_items, dependent: :destroy

    attachment :image

    validates :genre_id, :name, :price, presence: true
    validates :caption, length: {maximum: 200}
    validates :price, numericality: { only_integer: true }
end

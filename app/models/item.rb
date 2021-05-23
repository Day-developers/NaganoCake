class Item < ApplicationRecord
    belongs_to :genre
    has_many :cart_items, dependent: :destroy
    has_many :order_items, dependent: :destroy

    attachment :image

    validates :genre_id, :name, :price, presence: true
    validates :caption, length: {maximum: 200}
    validates :price, numericality: { only_integer: true }

    def self.looks(search)
      return none if search.blank?
      if search
        Item.where(['name LIKE ?', "%#{search}%"])
      else
        Item.all
      end
    end

end

class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, :first_name, :address, presence: true
  validates :kana_last_name, :kana_first_name, presence: true, format: { with: KATAKANA_REGEXP }
  validates :postal_code, presence: true, length: {is: 7}, numericality: { only_integer: true }
  validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX }

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  def self.looks(search)
    return none if search.blank?
    if search
      Customer.where(['last_name || first_name || kana_last_name || kana_first_name LIKE ?', "%#{search}%"])
    else
      Customer.all
    end
  end
end

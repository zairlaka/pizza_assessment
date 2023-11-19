class Item < ApplicationRecord
    has_many :order_items
    has_many :order, through: :order_items

    validates :price, presence: true
    validates :name, presence: true, length: { in: 3..20 ,
      too_long: "%{count} characters should be in a range of 3 to 20" }

    # scope :with_long_title, ->(length) { where("LENGTH(title) > ?", length) }

end

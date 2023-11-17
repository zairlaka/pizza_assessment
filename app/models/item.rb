class Item < ApplicationRecord
    has_many :order_items
    has_many :order, through: :order_items

    # scope :with_long_title, ->(length) { where("LENGTH(title) > ?", length) }

end

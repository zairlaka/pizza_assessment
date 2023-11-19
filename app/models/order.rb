class Order < ApplicationRecord
    BASE_PRICE = 50

    before_validation :calculate_and_set_prices

    enum size: %i[small medium large family]
    enum status: %i[open completed], _default: 'open'

    scope :missing_items, ->(ids) { Item.where.not(id: ids) }


    belongs_to :coupon, optional: true
    belongs_to :promotion, optional: true

    has_many :order_items
    has_many :items, through: :order_items

    def calculate_and_set_prices
        # calculate total price by adding item price
        # and exluding any discount and promotion price

        discount = coupon&.price.to_f
        promotion = promotion&.price.to_f

        self.total_discount = discount + promotion

        pizza_multiplier = Order::BASE_PRICE + (Order::BASE_PRICE * Order.sizes[size]) 
        # price will be multiply according to the size of the pizza with 50 which is our base
        price = pizza_multiplier

        items_price = items.sum(:price)
        items_multiplier = items_price + (2 * Order.sizes[size]) #for toppings base is set to 2 should be a constant in modal
        self.total_price = (price + items_multiplier) - total_discount
    end

end

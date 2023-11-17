# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Coupon.create([
    {code: '2-for-1', price: 10},
    {code: 'All for U', price: 10},
    {code: 'Double Trouble', price: 10}
])

puts "---------- Discount Coupons are created --------------" 

Promotion.create([
    {code: 'Tuesday Special', price: 10},
    {code: '11-11', price: 10},
    {code: 'Double Trouble', price: 10}
])

puts "---------- Discount Promotions are created --------------" 
Item.create([
    {name: 'Salami small', price: 1.50},
    {name: 'Salami regular', price: 1.90},
    {name: 'Cheese', price: 1.10},
    {name: 'Onions', price: 0.50},
    {name: 'Olives', price: 0.50}
])

puts "---------- Items are created --------------" 

Order.create([
    { total_discount: 50, total_price: 100, status: 0, size: 'small', coupon_id: 1, promotion: Promotion.find(2) },
    { total_discount: 50, total_price: 300, status: 0, size: 'large', coupon_id: 1, promotion: Promotion.find(2) }
])
puts "---------- Orders are created --------------"

OrderItem.create([
    {order_id: Order.first.id, item_id: Item.first.id},
    {order_id: Order.first.id, item_id: Item.find(3).id },
    {order_id: Order.first.id, item_id: Item.find(4).id},
    {order_id: Order.last.id, item_id: Item.find(3).id },
    {order_id: Order.last.id, item_id: Item.find(4).id}
])

puts "---------- Seeds are done --------------" 
Order.create(total_discount: 50, total_price: 100, status: 0, size: 'small', coupon_id: 1)
class CreateOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :orders  do |t|
      # uuid not suported in sqlite by default 
      t.decimal :total_price
      t.decimal :total_discount
      t.integer :status, null: false, default: 0 # default constraint is not working for sqlite

      t.integer :size

      t.references :coupon
      t.references :promotion
      t.timestamps
    end
  end
end

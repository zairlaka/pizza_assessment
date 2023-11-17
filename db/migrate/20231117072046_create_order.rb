class CreateOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :orders  do |t|
      t.decimal :total_price
      t.decimal :total_discount
      t.integer :status #preparation or completed
      t.integer :size

      t.references :coupon
      t.references :promotion
      t.timestamps
    end
  end
end

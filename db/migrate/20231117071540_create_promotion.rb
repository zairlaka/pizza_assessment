class CreatePromotion < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.string :code
      t.decimal :price

      t.timestamps
    end
  end
end

class CreateAmountOrders < ActiveRecord::Migration
  def change
    create_table :amount_orders do |t|
      t.text :item
      t.text :comment
      t.integer :amount
      t.float :price
      t.references :order, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

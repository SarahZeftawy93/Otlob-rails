class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :order
      t.text :place
      t.text :Image
      t.datetime :date
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

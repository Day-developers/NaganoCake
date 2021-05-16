class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :number
      t.integer :making_status, null: false, default: 0
      t.integer :price

      t.timestamps
    end
  end
end

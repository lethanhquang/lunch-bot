class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :username
      t.references :dish, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

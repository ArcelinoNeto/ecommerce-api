class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.decimal :total_price, precision: 10, scale: 2, null: false, default: 0
      t.string :customer_name, null: false
      t.string :customer_email, null: false
      t.text :shipping_address, null: false
      t.text :notes

      t.timestamps
    end

    add_index :orders, :status
  end
end

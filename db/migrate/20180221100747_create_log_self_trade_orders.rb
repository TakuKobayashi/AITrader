class CreateLogSelfTradeOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :log_self_trade_orders do |t|
      t.integer :state, null: false, default: 0
      t.integer :mst_exchange_id, null: false
      t.string :tid, null: false
      t.string :trade_method, null: false
      t.integer :from_wallet_id, null: false
      t.integer :to_wallet_id, null: false
      t.float :price, null: false, default: 0
      t.float :amount, null: false, default: 0
      t.datetime :traded_at
      t.datetime :canceled_at
      t.timestamps
    end
    add_index :log_self_trade_orders, [:tid, :mst_exchange_id], unique: true
  end
end

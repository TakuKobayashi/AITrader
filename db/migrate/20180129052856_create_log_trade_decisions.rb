class CreateLogTradeDecisions < ActiveRecord::Migration[5.1]
  def change
    create_table :log_trade_decisions do |t|
      t.integer :mst_exchange_id, null: false
      t.integer :from_currency_id, null: false
      t.integer :to_currency_id, null: false
      t.integer :log_wallet_movement_id
      t.float :from_before_amount, null: false, default: 0
      t.float :from_after_amount, null: false, default: 0
      t.float :from_move_amount, null: false, default: 0
      t.float :to_before_amount, null: false, default: 0
      t.float :to_after_amount, null: false, default: 0
      t.float :to_move_amount, null: false, default: 0
      t.datetime :traded_at, null: false
      t.timestamps
    end
    add_index :log_trade_decisions, :log_wallet_movement_id
    add_index :log_trade_decisions, :traded_at
  end
end

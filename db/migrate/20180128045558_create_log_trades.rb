class CreateLogTrades < ActiveRecord::Migration[5.1]
  def change
    create_table :log_trades do |t|
      t.integer :mst_exchange_id, null: false
      t.integer :mst_currency_pair_id, null: false
      t.string :tid, null: false
      t.string :trade_method, null: false
      t.float :price, null: false, default: 0
      t.float :amount, null: false, default: 0
      t.datetime :traded_time, null: false
    end
    add_index :log_trades, :traded_time
    add_index :log_trades, [:tid, :mst_exchange_id, :mst_currency_pair_id], unique: true, name: "log_trades_tid_pair_uniq_index"
  end
end

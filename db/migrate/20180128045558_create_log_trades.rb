class CreateLogTrades < ActiveRecord::Migration[5.1]
  def change
    create_table :log_trades do |t|
      t.integer :mst_exchange_id, null: false
      t.integer :mst_currency_pair_id, null: false
      t.string :tid, null: false
      t.integer :tarde_method, null: false, default: 0
      t.float :price, null: false, default: 0
      t.float :amount, null: false, default: 0
      t.datetime :traded_time, null: false
    end
    add_index :log_trades, :traded_time
    add_index :log_trades, :tid
  end
end

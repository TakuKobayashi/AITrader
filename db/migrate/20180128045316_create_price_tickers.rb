class CreatePriceTickers < ActiveRecord::Migration[5.1]
  def change
    create_table :price_tickers do |t|
      t.integer :mst_exchange_id, null: false
      t.integer :mst_currency_id, null: false
      t.float :high_price, null: false, default: 0
      t.float :low_price, null: false, default: 0
      t.float :last_price, null: false, default: 0
      t.float :vwap, null: false, default: 0
      t.float :volume, null: false, default: 0
      t.float :sign_bid, null: false, default: 0
      t.float :sign_ask, null: false, default: 0
      t.timestamps
    end

    add_index :price_tickers, [:created_at]
  end
end

class CreateMstCurrencyPairs < ActiveRecord::Migration[5.1]
  def change
    create_table :mst_currency_pairs do |t|
      t.integer :mst_exchange_id
      t.integer :from_currency_id, null: false
      t.integer :to_currency_id, null: false
      t.string :name, null: false
      t.float :maker_spread_rate, null: false, default: 0
      t.float :taker_spread_rate, null: false, default: 0
    end
  end
end

class CreateMstExchanges < ActiveRecord::Migration[5.1]
  def change
    create_table :mst_exchanges do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.string :url, null: false
      t.float :max_maker_spread_rate, null: false, default: 0
      t.float :max_taker_spread_rate, null: false, default: 0
    end
  end
end

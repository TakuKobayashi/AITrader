class CreateMstCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :mst_currencies do |t|
      t.integer :mst_exchange_id
      t.string :cid, null: false
      t.string :name, null: false
    end
  end
end

class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets do |t|
      t.integer :mst_exchange_id, null: false
      t.integer :mst_currency_id, null: false
      t.float :amount, null: false, default: 0
      t.string :type
      t.timestamps
    end
  end
end

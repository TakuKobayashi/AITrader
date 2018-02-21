class CreateLogWalletMovements < ActiveRecord::Migration[5.1]
  def change
    create_table :log_wallet_movements do |t|
      t.integer :wallet_id, null: false
      t.integer :movement_state, null: false, default: 0
      t.integer :log_self_trade_order_id, null: false
      t.float :before_amount, null: false, default: 0
      t.float :after_amount, null: false, default: 0
      t.float :move_amount, null: false, default: 0
      t.timestamps
    end
    add_index :log_wallet_movements, :log_self_trade_order_id
    add_index :log_wallet_movements, :created_at
  end
end

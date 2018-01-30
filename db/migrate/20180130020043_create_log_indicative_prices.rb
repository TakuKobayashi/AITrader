class CreateLogIndicativePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :log_indicative_prices do |t|
      t.string :group_token, null: false
      t.integer :offer_action, null: false, default: 0
      t.float :price, null: false, default: 0
      t.float :amount, null: false, default: 0
      t.timestamps
    end
    add_index :log_indicative_prices, :group_token
    add_index :log_indicative_prices, :created_at
  end
end

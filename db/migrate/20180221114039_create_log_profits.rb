class CreateLogProfits < ActiveRecord::Migration[5.1]
  def change
    create_table :log_profits do |t|
      t.float :start_price, null: false, default: 0
      t.float :profit_jpy, null: false, default: 0
      t.float :percentage, null: false, default: 0
      t.datetime :calcurated_at, null: false
    end
    add_index :log_profits, :calcurated_at
  end
end

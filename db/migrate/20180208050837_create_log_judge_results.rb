class CreateLogJudgeResults < ActiveRecord::Migration[5.1]
  def change
    create_table :log_judge_results do |t|
      t.integer :action, null: false, default: 0
      t.integer :result_action, null: false, default: 0
      t.integer :mst_currency_pair_id, null: false
      t.float :lot_rate, null: false, default: 0
      t.float :lot_result_value, null: false, default: 0
      t.float :price, null: false, default: 0
      t.float :amount, null: false, default: 0
      t.float :price_rate, null: false, default: 0
      t.text :extra_params
      t.timestamps
    end
    add_index :log_judge_results, :created_at
  end
end

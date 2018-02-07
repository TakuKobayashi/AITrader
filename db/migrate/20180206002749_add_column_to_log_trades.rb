class AddColumnToLogTrades < ActiveRecord::Migration[5.1]
  def up
    add_column :log_trades, :section_number, :integer, null: false, limit: 8, default: 0
    add_index :log_trades, :section_number
    Log::Trade.find_each do |trade|
      trade.section = trade.traded_time
      trade.save!
    end
  end

  def down
    remove_column :log_trades, :section_number
  end
end

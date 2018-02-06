class AddColumnToLogTrades < ActiveRecord::Migration[5.1]
  def up
    add_column :log_trades, :section_number, :integer, null: false, limit: 8, default: 0
    add_index :log_trades, :section_number
    Log::Trade.find_each do |trade|
      section_number = trade.trade_time.strftime("%Y%m%d%H").to_i * 100 + ((trade.trade_time.minutes / 5).to_i * 5)
      trade.update!(section_number: section_number)
    end
  end

  def down
    remove_column :log_trades, :section_number
  end
end

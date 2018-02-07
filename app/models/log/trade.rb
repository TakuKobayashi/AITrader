# == Schema Information
#
# Table name: log_trades
#
#  id                   :integer          not null, primary key
#  mst_exchange_id      :integer          not null
#  mst_currency_pair_id :integer          not null
#  tid                  :string(255)      not null
#  trade_method         :string(255)      not null
#  price                :float(24)        default(0.0), not null
#  amount               :float(24)        default(0.0), not null
#  section_number       :integer          default(0), not null
#  traded_time          :datetime         not null
#
# Indexes
#
#  index_log_trades_on_section_number  (section_number)
#  index_log_trades_on_traded_time     (traded_time)
#  log_trades_tid_pair_uniq_index      (tid,mst_exchange_id,mst_currency_pair_id) UNIQUE
#

class Log::Trade < ApplicationRecord
  SPLIT_MINUTES = 5

  def section
    return self.section_number
  end

  def section=(time)
    self.section_number = Log::Trade.calc_section_number(time)
  end

  def self.calc_section_number(time)
    return time.strftime("%Y%m%d%H").to_i * 100 + ((time.strftime("%M").to_i / SPLIT_MINUTES).to_i * SPLIT_MINUTES)
  end
end

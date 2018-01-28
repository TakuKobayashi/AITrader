# == Schema Information
#
# Table name: log_trades
#
#  id                   :integer          not null, primary key
#  mst_exchange_id      :integer          not null
#  mst_currency_pair_id :integer          not null
#  tid                  :string(255)      not null
#  tarde_method         :integer          default(0), not null
#  price                :float(24)        default(0.0), not null
#  amount               :float(24)        default(0.0), not null
#  traded_time          :datetime         not null
#
# Indexes
#
#  index_log_trades_on_tid          (tid)
#  index_log_trades_on_traded_time  (traded_time)
#

class Log::Trade < ApplicationRecord
end

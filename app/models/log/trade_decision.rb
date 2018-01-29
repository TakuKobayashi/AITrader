# == Schema Information
#
# Table name: log_trade_decisions
#
#  id                     :integer          not null, primary key
#  mst_exchange_id        :integer          not null
#  from_currency_id       :integer          not null
#  to_currency_id         :integer          not null
#  log_wallet_movement_id :integer
#  from_before_amount     :float(24)        default(0.0), not null
#  from_after_amount      :float(24)        default(0.0), not null
#  from_move_amount       :float(24)        default(0.0), not null
#  to_before_amount       :float(24)        default(0.0), not null
#  to_after_amount        :float(24)        default(0.0), not null
#  to_move_amount         :float(24)        default(0.0), not null
#  traded_at              :datetime         not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_log_trade_decisions_on_log_wallet_movement_id  (log_wallet_movement_id)
#  index_log_trade_decisions_on_traded_at               (traded_at)
#

class Log::TradeDecision < ApplicationRecord
end
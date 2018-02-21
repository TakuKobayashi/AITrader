# == Schema Information
#
# Table name: log_wallet_movements
#
#  id                      :integer          not null, primary key
#  wallet_id               :integer          not null
#  movement_state          :integer          default("unknown"), not null
#  log_self_trade_order_id :integer          not null
#  before_amount           :float(24)        default(0.0), not null
#  after_amount            :float(24)        default(0.0), not null
#  move_amount             :float(24)        default(0.0), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_log_wallet_movements_on_created_at               (created_at)
#  index_log_wallet_movements_on_log_self_trade_order_id  (log_self_trade_order_id)
#

class Log::WalletMovement < ApplicationRecord
  enum movement_state: Log::SelfTradeOrder.states

  belongs_to :wallet, class_name: 'Wallet', foreign_key: :wallet_id, required: false
  belongs_to :self_trade_order, class_name: 'Log::SelfTradeOrder', foreign_key: :log_self_trade_order_id, required: false
end

# == Schema Information
#
# Table name: log_wallet_movements
#
#  id                      :integer          not null, primary key
#  wallet_id               :integer          not null
#  movement_state          :integer          default(0), not null
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

require 'test_helper'

class Log::WalletMovementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

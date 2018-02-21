# == Schema Information
#
# Table name: log_self_trade_orders
#
#  id              :integer          not null, primary key
#  state           :integer          default(0), not null
#  mst_exchange_id :integer          not null
#  tid             :string(255)      not null
#  trade_method    :string(255)      not null
#  from_wallet_id  :integer          not null
#  to_wallet_id    :integer          not null
#  price           :float(24)        default(0.0), not null
#  amount          :float(24)        default(0.0), not null
#  traded_at       :datetime
#  canceled_at     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_log_self_trade_orders_on_tid_and_mst_exchange_id  (tid,mst_exchange_id) UNIQUE
#

require 'test_helper'

class Log::SelfTradeOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

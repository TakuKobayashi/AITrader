# == Schema Information
#
# Table name: price_tickers
#
#  id              :integer          not null, primary key
#  mst_exchange_id :integer          not null
#  mst_currency_id :integer          not null
#  high_price      :float(24)        default(0.0), not null
#  low_price       :float(24)        default(0.0), not null
#  last_price      :float(24)        default(0.0), not null
#  vwap            :float(24)        default(0.0), not null
#  volume          :float(24)        default(0.0), not null
#  sign_bid        :float(24)        default(0.0), not null
#  sign_ask        :float(24)        default(0.0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_price_tickers_on_created_at  (created_at)
#

require 'test_helper'

class PriceTickerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

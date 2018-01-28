# == Schema Information
#
# Table name: mst_currency_pairs
#
#  id                :integer          not null, primary key
#  mst_exchange_id   :integer
#  from_currency_id  :integer          not null
#  to_currency_id    :integer          not null
#  cpid              :string(255)
#  name              :string(255)      not null
#  pair_name         :string(255)
#  is_token          :boolean          default(TRUE), not null
#  maker_spread_rate :float(24)        default(0.0), not null
#  taker_spread_rate :float(24)        default(0.0), not null
#  description       :text(65535)
#

require 'test_helper'

class Mst::CurrencyPairTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: wallets
#
#  id              :integer          not null, primary key
#  mst_exchange_id :integer          not null
#  mst_currency_id :integer          not null
#  amount          :float(24)        default(0.0), not null
#  type            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: log_profits
#
#  id            :integer          not null, primary key
#  start_price   :float(24)        default(0.0), not null
#  profit_jpy    :float(24)        default(0.0), not null
#  percentage    :float(24)        default(0.0), not null
#  calcurated_at :datetime         not null
#
# Indexes
#
#  index_log_profits_on_calcurated_at  (calcurated_at)
#

require 'test_helper'

class Log::ProfitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

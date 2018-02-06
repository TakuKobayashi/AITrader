# == Schema Information
#
# Table name: log_indicative_prices
#
#  id             :integer          not null, primary key
#  group_number   :integer          default(0), not null
#  offer_action   :integer          default("ask"), not null
#  price          :float(24)        default(0.0), not null
#  amount         :float(24)        default(0.0), not null
#  section_number :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_log_indicative_prices_on_created_at      (created_at)
#  index_log_indicative_prices_on_group_number    (group_number)
#  index_log_indicative_prices_on_section_number  (section_number)
#

require 'test_helper'

class Log::IndicativePriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

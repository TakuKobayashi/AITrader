# == Schema Information
#
# Table name: log_judge_results
#
#  id                   :integer          not null, primary key
#  action               :integer          default("nothing"), not null
#  result_action        :integer          default(0), not null
#  mst_currency_pair_id :integer          not null
#  lot_rate             :float(24)        default(0.0), not null
#  lot_result_value     :float(24)        default(0.0), not null
#  price                :float(24)        default(0.0), not null
#  amount               :float(24)        default(0.0), not null
#  pay_rate             :float(24)        default(0.0), not null
#  extra_params         :text(65535)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_log_judge_results_on_created_at  (created_at)
#

require 'test_helper'

class Log::JudgeResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

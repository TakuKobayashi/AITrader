# == Schema Information
#
# Table name: log_judge_results
#
#  id                   :integer          not null, primary key
#  action               :integer          default("unknown"), not null
#  result_chain         :integer          default(0), not null
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

class Log::JudgeResult < ApplicationRecord
  serialize :extra_params, JSON

  RECORD_CHAIN_COUNT = 16

  enum action: {
    unknown: 0,
    nothing: 1,
    ask: 2,
    bid: 3,
    out_lottery: 4,
    not_enough: 5
  }

  def record_chain(before_judge:)
    self.result_chain = (before_judge.result_chain * 10 + Log::JudgeResult.actions[self.action]) % (10 ** RECORD_CHAIN_COUNT)
  end
end

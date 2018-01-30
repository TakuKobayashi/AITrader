# == Schema Information
#
# Table name: log_indicative_prices
#
#  id           :integer          not null, primary key
#  group_token  :string(255)      not null
#  offer_action :integer          default("ask"), not null
#  price        :float(24)        default(0.0), not null
#  amount       :float(24)        default(0.0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_log_indicative_prices_on_created_at   (created_at)
#  index_log_indicative_prices_on_group_token  (group_token)
#

class Log::IndicativePrice < ApplicationRecord
  enum offer_action: {
    ask: 0,
    bid: 1
  }
end

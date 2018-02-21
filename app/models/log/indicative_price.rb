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

class Log::IndicativePrice < ApplicationRecord
  enum offer_action: {
    unknown: 0,
    ask: 1,
    bid: 2
  }

  def section
    return self.section_number
  end

  def section=(time)
    self.section_number = Log::Trade.calc_section_number(time)
  end

  # 直近の価格帯で最も人気のある価格を選択する
  def self.last_most_popular_price(offer_action: :ask)
    last_price = Log::IndicativePrice.where(offer_action: offer_action).last
    last_prices = Log::IndicativePrice.where(offer_action: offer_action, group_number: last_price.group_number)
    popular_price = last_prices.max_by{|price| price.amount }
    return popular_price
  end

  def calc_trade_amount(price_sum:)
    if self.price.zero?
      return 0
    end
    return price_sum.to_f / self.price.to_f
  end
end

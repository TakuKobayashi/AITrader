# == Schema Information
#
# Table name: mst_exchanges
#
#  id                    :integer          not null, primary key
#  type                  :string(255)      not null
#  name                  :string(255)      not null
#  url                   :string(255)      not null
#  max_maker_spread_rate :float(24)        default(0.0), not null
#  max_taker_spread_rate :float(24)        default(0.0), not null
#

class Mst::Exchange < ApplicationRecord
  has_many :currencies, class_name: 'Mst::Currency', foreign_key: :mst_exchange_id
  has_many :currency_pairs, class_name: 'Mst::CurrencyPair', foreign_key: :mst_exchange_id
end

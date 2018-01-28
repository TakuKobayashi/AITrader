# == Schema Information
#
# Table name: mst_exchanges
#
#  id                    :integer          not null, primary key
#  name                  :string(255)      not null
#  url                   :string(255)      not null
#  max_maker_spread_rate :float(24)        default(0.0), not null
#  max_taker_spread_rate :float(24)        default(0.0), not null
#

class Mst::Exchange < ApplicationRecord
end

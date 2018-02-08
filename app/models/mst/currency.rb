# == Schema Information
#
# Table name: mst_currencies
#
#  id              :integer          not null, primary key
#  mst_exchange_id :integer
#  cid             :string(255)      not null
#  name            :string(255)      not null
#

class Mst::Currency < ApplicationRecord
  belongs_to :exchange, class_name: 'Mst::Exchange', foreign_key: :mst_exchange_id, required: false
end

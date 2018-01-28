# == Schema Information
#
# Table name: mst_currencies
#
#  id              :integer          not null, primary key
#  mst_exchange_id :integer
#  cid             :string(255)      not null
#  name            :string(255)      not null
#

require 'test_helper'

class Mst::CurrencyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

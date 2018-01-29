# == Schema Information
#
# Table name: trace_connections
#
#  id                   :integer          not null, primary key
#  mst_currency_pair_id :integer
#  state                :integer          default("standby"), not null
#  url                  :string(255)      not null
#  opened_time          :datetime
#  closed_time          :datetime
#  closed_reason        :text(65535)
#
# Indexes
#
#  index_trace_connections_on_closed_time  (closed_time)
#  index_trace_connections_on_opened_time  (opened_time)
#  index_trace_connections_on_url          (url)
#

require 'test_helper'

class TraceConnectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

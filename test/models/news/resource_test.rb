# == Schema Information
#
# Table name: news_resources
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  type             :string(255)
#  news_resource_id :string(255)
#  url              :string(255)      not null
#  body             :text(65535)      not null
#  published_at     :datetime         not null
#  options          :text(65535)
#
# Indexes
#
#  index_news_resources_on_news_resource_id  (news_resource_id)
#  index_news_resources_on_published_at      (published_at)
#  index_news_resources_on_url               (url)
#

require 'test_helper'

class News::ResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

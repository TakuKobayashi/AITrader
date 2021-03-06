# == Schema Information
#
# Table name: blogger_bots
#
#  id                     :integer          not null, primary key
#  blogger_id             :string(255)      not null
#  from_type              :string(255)
#  from_id                :integer
#  title                  :string(255)      not null
#  body                   :text(65535)      not null
#  score                  :float(24)        not null
#  investigate_start_date :integer          not null
#  investigate_end_date   :integer          not null
#  published_at           :datetime         not null
#  input_body_resources   :text(65535)      not null
#  options                :text(65535)
#
# Indexes
#
#  blogger_bots_investigate_range_index         (investigate_start_date,investigate_end_date)
#  index_blogger_bots_on_blogger_id             (blogger_id)
#  index_blogger_bots_on_from_type_and_from_id  (from_type,from_id)
#  index_blogger_bots_on_score                  (score)
#
require 'google/apis/blogger_v3'

class BloggerBot < ApplicationRecord
  belongs_to :from, polymorphic: true, required: false

  serialize :input_body_resources, JSON
  serialize :options, JSON

  BLOGGER_BLOG_URL = "http://aivirtualtrader.blogspot.jp/"

  def self.post_blog!
    blog_html = ActionView::Base.new(Rails.root.join('app', 'views')).render(template: 'blog/format.html.erb', format: 'html', locals: { price: 100 })
    blogger_client = self.google_blogger_client
    blog = blogger_client.get_blog_by_url(BLOGGER_BLOG_URL)
  end

  def self.google_blogger_client
    service = Google::Apis::BloggerV3::BloggerService.new
    service.authorization = GoogleOauth2Client.oauth2_client(refresh_token: ENV.fetch("GOOGLE_OAUTH_BOT_BLOGGER_REFRESH_TOKEN", ""))
    return service
  end
end

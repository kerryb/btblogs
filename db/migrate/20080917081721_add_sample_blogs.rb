require 'feed-normalizer'

class AddSampleBlogs < ActiveRecord::Migration
  def self.up
    Dir.glob("#{RAILS_ROOT}/stories/sample_feeds/*").each do |f|
      feed = FeedNormalizer::FeedNormalizer.parse File.read(f)
      Blog.create! :feed_uri => f, :title => feed.title
    end
  end

  def self.down
    Blog.destroy_all
  end
end

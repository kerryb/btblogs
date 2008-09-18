require 'feed-normalizer'
require 'open-uri'

class Blog < ActiveRecord::Base
  has_many :entries 
  
  def update_entries
    feed = FeedNormalizer::FeedNormalizer.parse open(feed_uri)
    entries = feed.entries.map { |e| Entry.new :title => e.title,
        :published_at => e.date_published, :content => e.content }
    save!
  end
end

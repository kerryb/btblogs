class Blog < ActiveRecord::Base
  validates_presence_of :owner_name, :owner_email, :html_uri, :feed_uri
  attr_protected :confirmed
  named_scope :confirmed, :conditions => {:confirmed => true}
end

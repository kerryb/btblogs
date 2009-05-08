class Blog < ActiveRecord::Base
  validates_presence_of :owner_name, :owner_email, :html_uri, :feed_uri
  validates_format_of :owner_email, :with => /@bt.com$/, :message => 'must be @bt.com'

  attr_protected :confirmed
  named_scope :confirmed, :conditions => {:confirmed => true}
end

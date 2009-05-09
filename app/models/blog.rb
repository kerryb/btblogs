class Blog < ActiveRecord::Base
  validates_presence_of :owner_name, :owner_email, :html_uri, :feed_uri
  validates_format_of :owner_email, :with => /@bt.com$/, :message => 'must be @bt.com'

  attr_protected :confirmed
  named_scope :confirmed, :conditions => {:confirmed => true}

  before_save :set_confirmation_code

  def set_confirmation_code
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('1'..'9').to_a 
    self.confirmation_code = Array.new(20, '').collect{chars[rand(chars.size)]}.join
      
  end
end

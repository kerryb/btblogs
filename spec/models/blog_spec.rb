require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Blog do
  it { should have_db_column(:owner_name).of_type(:string) }
  it { should have_db_column(:owner_email).of_type(:string) }
  it { should have_db_column(:html_uri).of_type(:string) }
  it { should have_db_column(:feed_uri).of_type(:string) }
  it { should have_db_column(:confirmed).of_type(:boolean) }
  it { should validate_presence_of(:owner_name) }
  it { should validate_presence_of(:owner_email) }
  it { should validate_presence_of(:html_uri) }
  it { should validate_presence_of(:feed_uri) }
  it { should allow_value('fred.bloggs@bt.com').for(:owner_email) }
  it { should_not allow_value('fred.bloggs@not-bt.com').for(:owner_email).with_message('must be @bt.com') }
  it { should_not allow_value('bt.com@not-bt.com').for(:owner_email).with_message('must be @bt.com') }
  it { should_not allow_mass_assignment_of(:confirmed) }
  it { should have_named_scope(:confirmed).finding(:conditions => {:confirmed => true}) }
end

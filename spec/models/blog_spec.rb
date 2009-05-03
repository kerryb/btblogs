require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Blog do
  it 'should be an ActiveRecord' do
    Blog.new.should be_a_kind_of(ActiveRecord::Base)
  end

  it { should have_db_column(:owner_name).of_type(:string) }
  it { should have_db_column(:owner_email).of_type(:string) }
  it { should have_db_column(:html_uri).of_type(:string) }
  it { should have_db_column(:feed_uri).of_type(:string) }
end

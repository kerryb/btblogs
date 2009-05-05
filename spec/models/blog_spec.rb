require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Blog do
  it 'should be an ActiveRecord' do
    Blog.new.should be_a_kind_of(ActiveRecord::Base)
  end

  it { should have_db_column(:owner_name).of_type(:string) }
  it { should have_db_column(:owner_email).of_type(:string) }
  it { should have_db_column(:html_uri).of_type(:string) }
  it { should have_db_column(:feed_uri).of_type(:string) }
  it { should have_db_column(:confirmed).of_type(:boolean) }

  it { should validate_presence_of(:owner_name) }
  it { should validate_presence_of(:owner_email) }
  it { should validate_presence_of(:html_uri) }
  it { should validate_presence_of(:feed_uri) }

  it "should not mass-assign 'confirmed'" do
    Blog.new(:confirmed => true).confirmed.should be_nil
  end

  describe "named scope 'confirmed'" do
    it 'should only include confirmed blogs' do
      unconfirmed_blog = Factory :blog
      confirmed_blog = Factory :confirmed_blog
      Blog.confirmed.should == [confirmed_blog]
    end
  end
end

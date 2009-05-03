require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BlogsController do
  describe '#new' do
    it 'should be successful' do
      get :new
      response.should be_success
    end

    it 'should assign a new blog or the view' do
      blog = mock_model Blog
      Blog.stub!(:new).and_return blog
      get :new
      assigns[:blog].should == blog
    end
  end
end

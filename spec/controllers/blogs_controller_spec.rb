require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BlogsController do
  describe '#new' do
    it 'should be successful' do
      get :new
      response.should be_success
    end
  end
end

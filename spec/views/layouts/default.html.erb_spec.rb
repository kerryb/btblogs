require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe 'The default layout' do
  before do
    render :text => '', :layout => true
  end

  it 'should set the title' do
    response.should have_tag('title', 'BT Blogs')
  end
end

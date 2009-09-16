require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe 'The default layout' do
  def do_render
    render :text => '', :layout => true
  end

  it 'renders links to all blogs' do
    blog_1 = Factory :blog, :owner_name => 'Amy Acker', :html_uri => 'foo'
    blog_2 = Factory :blog, :owner_name => 'Bill Bailey', :html_uri => 'bar'
    assigns[:blogs] = [blog_1, blog_2]
    do_render
    response.should have_tag('div#blogs') do
      with_tag "a[href='foo']", 'Amy Acker'
      with_tag "a[href='bar']", 'Bill Bailey'
    end
  end

  describe 'when there is a flash notice' do
    it 'renders the notice' do
      flash[:notice] = 'Hello'
      do_render
      response.should have_tag('div#notice', 'Hello')
    end
  end

  describe 'when there is not a flash notice' do
    it 'does not render a notice div' do
      do_render
      response.should_not have_tag('div#notice')
    end
  end
end

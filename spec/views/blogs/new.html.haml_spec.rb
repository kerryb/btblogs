require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe 'The new blog page' do
  before do
    assigns[:blog] = Blog.new
  end

  def do_render
    render 'blogs/new.html.haml'
  end

  it 'should render a create user form' do
    do_render
    response.should have_tag("form[action='/blogs']") do
      with_tag "input[type='text'][name='blog[owner_name]']"
      with_tag "input[type='text'][name='blog[owner_email]']"
      with_tag "input[type='text'][name='blog[html_uri]']"
      with_tag "input[type='text'][name='blog[feed_uri]']"
      with_tag "input[type='submit'][value='save']"
      with_tag "input[type='submit'][value='cancel']"
    end
  end

  it 'should render any errors' do
    assigns[:blog].errors.add :owner_name, 'is a silly name'
    do_render
    response.should have_tag("div[class='errorExplanation']") do
      with_tag 'li', 'Owner name is a silly name'
    end
  end
end

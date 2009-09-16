require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class FooController < ApplicationController
  def foo
    render :text => '', :layout => true
  end
end

ActionController::Routing::Routes.draw do |map|
  map.connect '/foo', :controller => 'foo', :action => 'foo'
end

describe ApplicationController do
  controller_name :foo

  it 'uses the default layout' do
    get :foo
    response.layout.should == 'layouts/default'
  end

  it 'assigns a list of confirmed blogs for the view' do
    confirmed_blog_1 = Factory(:confirmed_blog)
    unconfirmed_blog = Factory(:blog)
    confirmed_blog_2 = Factory(:confirmed_blog)
    get :foo
    assigns[:blogs].should == [confirmed_blog_1, confirmed_blog_2]
  end
end

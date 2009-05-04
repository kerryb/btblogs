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

  it 'should use the default layout' do
    get :foo
    response.layout.should == 'layouts/default'
  end
end

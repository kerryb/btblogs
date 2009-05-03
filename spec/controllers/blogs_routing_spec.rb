require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Routing for", BlogsController do
  it { should route(:get, '/blogs/new').to(:controller => 'blogs', :action => 'new') }
end

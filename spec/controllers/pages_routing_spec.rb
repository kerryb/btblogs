require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Routing for", PagesController do
  it { should route(:get, '/').to(:controller => 'pages', :action => 'home') }
end

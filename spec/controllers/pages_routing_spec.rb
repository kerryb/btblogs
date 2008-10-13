require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Routing for", PagesController do
  describe "route generation" do
    it "should map #home" do
      route_for(:controller => "pages", :action => "home").should == "/"
    end
  end

  describe "route recognition" do
    it "should generate params for #home" do
      params_from(:get, "/").should == {:controller => "pages", :action => "home"}
    end
  end
end

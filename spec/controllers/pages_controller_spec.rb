require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController do
  describe '#home' do
    it 'should render home.html.erb' do
      get :home
      response.should render_template('home.html.erb')
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController do
  describe '#home' do
    it 'renders home' do
      get :home
      response.should render_template('home')
    end
  end
end

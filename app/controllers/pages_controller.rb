class PagesController < ApplicationController
  def home
    render :action => 'home.html.erb'
  end
end

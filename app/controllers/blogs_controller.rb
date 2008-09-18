class BlogsController < ApplicationController
  def index
    @entries = Entry.all :order => 'published_at desc', :include => :blog
    respond_to do |format|
      format.html
      format.rss  { render :action => 'index.rss.builder', :layout => false }
    end
  end
end
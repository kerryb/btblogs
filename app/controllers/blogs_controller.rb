class BlogsController < ApplicationController
  def new
    @blog = Blog.new
  end

  def create
    return redirect_to(root_url) if params[:commit] == 'cancel'
    @blog = Blog.new params[:blog]
    if @blog.save
      ConfirmationMailer.deliver_confirmation @blog
      flash[:notice] = 'Thank you for adding your blog. You should receive an e-mail shortly, with a confirmation link.'
      redirect_to root_url
    else
      render :action => :new
    end
  end

  def confirm
    blog = Blog.find_by_confirmation_code params[:confirmation_code]
    if blog
      blog.confirmed = true
      blog.save!
      flash[:notice] = 'Thank you, your blog has now been confirmed.'
    else
      flash[:notice] = 'Sorry, that confirmation code was not recognised.'
    end
    redirect_to root_url
  end
end

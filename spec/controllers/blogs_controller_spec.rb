require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BlogsController do
  describe '#new' do
    it 'should be successful' do
      get :new
      response.should be_success
    end

    it 'should assign a new blog for the view' do
      blog = mock_model Blog
      Blog.stub!(:new).and_return blog
      get :new
      assigns[:blog].should == blog
    end
  end

  describe '#create' do
    before do
      @params = stub :params
      @blog = mock_model Blog, :save => true
      Blog.stub!(:new).and_return @blog
    end

    def do_post
      post :create, :blog => params
    end

    describe 'when the submission was cancelled' do
      def do_post
        post :create, :commit => 'cancel'
      end

      it 'should redirect back to the home page' do
        do_post
        response.should redirect_to('/')
      end

      it 'should not create a new blog record' do
        Blog.should_not_receive :new
        do_post
      end
    end

    it 'should create a new blog record' do
      Blog.should_receive(:new).with params
      do_post
    end

    it 'should be attempt to save the record' do
      @blog.should_receive(:save)
      do_post
    end

    describe 'when record creation fails' do
      before do
        @blog.stub!(:save).and_return false
      end

      it 'should re-render the new blog form' do
        do_post
        response.should render_template(:new)
      end

      it 'should assign the blog for the view' do
        do_post
        assigns[:blog].should == @blog
      end
    end

    describe 'when record creation succeeds' do
      before do
        @blog.stub!(:save).and_return true
      end

      it 'should redirect to the home page' do
        do_post
        response.should redirect_to(root_url)
      end

      it 'should put a message in the flash' do
        do_post
        flash[:notice].should == 'Thank you for adding your blog. You should receive an e-mail shortly, with a confirmation link.'
      end
    end
  end
end

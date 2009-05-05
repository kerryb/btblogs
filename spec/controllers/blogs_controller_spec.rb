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
      @email = 'fred.bloggs@bt.com'
      @params = {'blog' => {'owner_email' => @email}}
    end

    def do_post
      post :create, @params
    end

    describe 'when the submission was cancelled' do
      def do_post
        post :create, @params.merge('commit' => 'cancel')
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

    it 'should create and save a new blog record' do
      blog = mock_model Blog
      Blog.stub!(:new).with(@params['blog']).and_return blog
      blog.should_receive(:save)
      do_post
    end

    describe 'when record creation fails' do
      before do
        @blog = mock_model Blog, :save => false
        Blog.stub!(:new).and_return @blog
      end

      it 'should not send a confirmation e-mail' do
        ConfirmationMailer.should_not_receive :deliver_confirmation
        do_post
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
        Blog.stub!(:new).and_return mock_model(Blog, :save => true)
        ConfirmationMailer.stub! :deliver_confirmation
      end

      it 'should redirect to the home page' do
        do_post
        response.should redirect_to(root_url)
      end

      it 'should send a confirmation e-mail' do
        ConfirmationMailer.should_receive(:deliver_confirmation).with(@email)
        do_post
      end

      it 'should put a message in the flash' do
        do_post
        flash[:notice].should == 'Thank you for adding your blog. You should receive an e-mail shortly, with a confirmation link.'
      end
    end
  end
end

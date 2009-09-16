require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BlogsController do
  describe '#new' do
    it 'is successful' do
      get :new
      response.should be_success
    end

    it 'assigns a new blog for the view' do
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

      it 'redirects back to the home page' do
        do_post
        response.should redirect_to('/')
      end

      it 'does not create a new blog record' do
        Blog.should_not_receive :new
        do_post
      end
    end

    it 'creates and save a new blog record' do
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

      it 'does not send a confirmation e-mail' do
        ConfirmationMailer.should_not_receive :deliver_confirmation
        do_post
      end

      it 're-renders the new blog form' do
        do_post
        response.should render_template(:new)
      end

      it 'assigns the blog for the view' do
        do_post
        assigns[:blog].should == @blog
      end
    end

    describe 'when record creation succeeds' do
      before do
        @blog = mock_model(Blog, :save => true)
        Blog.stub!(:new).and_return @blog
        ConfirmationMailer.stub! :deliver_confirmation
      end

      it 'redirects to the home page' do
        do_post
        response.should redirect_to(root_url)
      end

      it 'sends a confirmation e-mail' do
        ConfirmationMailer.should_receive(:deliver_confirmation).with(@blog)
        do_post
      end

      it 'puts a message in the flash' do
        do_post
        flash[:notice].should == 'Thank you for adding your blog. You should receive an e-mail shortly, with a confirmation link.'
      end
    end
  end

  describe '#confirm' do
    describe 'when the code matches' do
      before do
        @blog = Factory :blog
      end

      def do_get
        get :confirm, :confirmation_code => @blog.confirmation_code
      end

      it 'should mark the blog as confirmed' do
        do_get
        @blog.reload
        @blog.confirmed.should be_true
      end

      it 'should redirect to the home page' do
        do_get
        response.should redirect_to(root_url)
      end

      it 'should put a message in the flash' do
        do_get
        flash[:notice].should == 'Thank you, your blog has now been confirmed.'
      end
    end
  
    describe 'when the code does not match' do
      before do
        @blog = Factory :blog, :confirmation_code => '123'
      end

      def do_get
        get :confirm, :confirmation_code => 456
      end

      it 'should not mark the blog as confirmed' do
        do_get
        @blog.reload
        @blog.confirmed.should_not be_true
      end

      it 'should redirect to the home page' do
        do_get
        response.should redirect_to(root_url)
      end

      it 'should put a message in the flash' do
        do_get
        flash[:notice].should == 'Sorry, that confirmation code was not recognised.'
      end
    end
  end
end

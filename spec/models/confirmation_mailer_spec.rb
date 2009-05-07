require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ConfirmationMailer do
  describe 'sending confirmation' do
    before do
      @email = 'fred.bloggs@bt.com'
      @blog = mock_model Blog, :owner_email => @email
    end

    def create_mail
      ConfirmationMailer.create_confirmation @blog
    end

    it 'should set the from address' do
      create_mail.from.should == ['admin@btblo.gs']
    end

    it 'should send to the specified address' do
      create_mail.to.should == [@email]
    end

    it "should have a subject of 'BTBlo.gs Confirmation'" do
      create_mail.subject.should == 'BTBlo.gs Confirmation'
    end

    it "should show the registered blog's URL" do
      create_mail.body.should =~ %r(/blogs/#{@blog.id}/confirm)
    end
  end
end

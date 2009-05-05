require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ConfirmationMailer do
  describe 'sending confirmation' do
    def create_mail
      ConfirmationMailer.create_confirmation('fred.bloggs@bt.com')
    end

    it 'should set the from address' do
      create_mail.from.should == ['admin@btblo.gs']
    end

    it 'should send to the specified address' do
      create_mail.to.should == ['fred.bloggs@bt.com']
    end
  end
end

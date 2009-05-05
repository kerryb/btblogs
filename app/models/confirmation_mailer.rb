class ConfirmationMailer < ActionMailer::Base
  def confirmation address
    recipients address
    from 'admin@btblo.gs'
  end
end

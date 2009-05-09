class ConfirmationMailer < ActionMailer::Base
  def confirmation blog
    @blog = blog
    default_url_options[:host] = 'btblo.gs'
    recipients blog.owner_email
    from 'admin@btblo.gs'
    subject 'BTBlo.gs Confirmation'
  end
end

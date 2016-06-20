class ContactUsPreview < ActionMailer::Preview
  def sample_mail_preview
    ContactUs.send_mail()
  end
end

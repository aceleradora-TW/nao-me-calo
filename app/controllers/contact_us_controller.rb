class ContactUsController < ApplicationController
  def index
      ContactUs.welcome_email.deliver_now
    end

    def send_mail
      ContactUs.welcome_email.deliver_now
      redirect_to "/faleconosco"
    end


end

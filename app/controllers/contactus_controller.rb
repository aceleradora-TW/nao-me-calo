class ContactusController < ApplicationController

  def index
  end

  def send_mail
    ContactUs.welcome_email.deliver_now
    redirect_to "/faleconosco"

  end

end

class ContactUsController < ApplicationController
  def index
    end

    def send_mail
      @message = params[:message]
      @email = params[:email]
      @subject = params[:subject]
      @name = params[:name]
      ContactUs.welcome_email(@name, @email, @subject, @message).deliver_now
      redirect_to "/faleconosco"
    end

end

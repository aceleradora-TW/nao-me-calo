class ContactUsController < ApplicationController
  include ApplicationHelper
  
  def index
  end

  def send_mail
    @message = params[:message]
    @email = params[:email]
    @subject = params[:subject]
    @name = params[:name]
    ContactUs.welcome_email(@name, @email, @subject, @message).deliver_now
    respond_to do |format|
      format.html { redirect_to "/faleconosco", notice: 'Mensagem enviada com sucesso!' }
    end
  end

end

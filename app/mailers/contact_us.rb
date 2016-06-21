class ContactUs < ApplicationMailer
  def welcome_email(name, email, subject, message)
    @name = name
    @email = email
    @subject = subject
    @message = message
    mail(to: 'aceleradoratw9@gmail.com', subject: 'Não me Calo Fale Conosco')
  end
end

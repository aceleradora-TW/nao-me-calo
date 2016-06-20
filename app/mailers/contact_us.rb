class ContactUs < ApplicationMailer
  def welcome_email()
    # @user = user
    # @url  = 'http://example.com/login'
    mail(to: 'pedrofilosofo@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end

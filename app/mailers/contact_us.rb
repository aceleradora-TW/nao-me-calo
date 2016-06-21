class ContactUs < ApplicationMailer
  def welcome_email()
    # @user = user
    # @url  = 'http://example.com/login'
    mail(to: 'aceleradoratw9@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end

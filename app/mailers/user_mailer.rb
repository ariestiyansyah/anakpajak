class UserMailer < ActionMailer::Base
  default from: "noreply@anakpajak.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: "aji.achmad@icloud.com", subject: 'Welcome to My Awesome Site')
  end
end

class UserMailer < ApplicationMailer
  default from: 'centurion@example.com'

  def send_invitation(data)
    @email = data[:email]
    @url  = data[:url]
    mail(to: @email, subject: 'Please join Centurion')
  end
end

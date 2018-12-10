class UserMailer < ApplicationMailer
  default from: "digyouradventure@gmail.com"

  def send_email(user)
    @user = user
    @url = ''
    mail(
      to: @user.email,
      subject: ''
    )
  end
end

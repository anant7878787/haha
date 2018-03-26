class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
  def invitation_send(invitemail)
    @user = invitemail

    mail(to: @user)
  end
end

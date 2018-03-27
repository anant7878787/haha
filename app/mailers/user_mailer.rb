class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
  def invitation_send(invitemail,acc_id)
    @user = invitemail
    @acc_id = acc_id
    mail(to: @user)
  end
end

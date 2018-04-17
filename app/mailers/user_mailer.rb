class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
  def invitation_send(invitemail,acc_id, key)
  	@user = invitemail
    @acc_id = acc_id
    @key = key
    mail(to: @user)
  end
end
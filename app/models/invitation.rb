class Invitation < ApplicationRecord
  
	#sending emails method
	def self.check_for_user(email) 
		return User.find_by(email: email)
        debugger
	end 

	def self.creating_users_in_invitation(check_user, account_id, email, key)
        debugger
		if check_user == nil
            @invitation = Invitation.create(account_id: account_id, user_email: email, key: key)
            UserMailer.invitation_send(email, account_id, key).deliver_now
            return true
        else  
            begin 
                @invitation = Invitation.create(account_id: account_id, user_id: check_user.id, user_email: email, key: key)
                UserMailer.invitation_send(email, account_id, key).deliver_now
                return true
            rescue
               return false
            end
        end
	end
end

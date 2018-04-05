class Invitation < ApplicationRecord
  
	#sending emails method
	def self.check_for_user(email)
		User.find_by(email: email)
	end

	def self.creating_users_in_invitation(check, account_id, email)

		if check == nil
            @invitation = Invitation.create(account_id: account_id, user_email: email)
            UserMailer.invitation_send(email, account_id).deliver_now
            return true
        else 
            begin
                @invitation = Invitation.create(account_id: account_id, user_id: check.id, user_email: email)
                UserMailer.invitation_send(email, account_id).deliver_now
                return true
            rescue
               return false
            end
        end
	end
end




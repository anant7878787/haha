class Invitation < ApplicationRecord
  
	#sending emails method
	def self.check_for_user(email) 
		return User.find_by(email: email)
	end  
end

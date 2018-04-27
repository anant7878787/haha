class Team < ApplicationRecord
	has_many :messages
	has_many :comments, as: :commentable
	#Methods for get_name and get_teaminfo method
	

	def find_teamusers_to_show
      @teamusers = Teamuser.where(team_id: id).pluck(:user_id)
	  @usrr = User.where(id: @teamusers)
      @usrr
    end
    def find_invited_users_for_modal(accounts)
		@owner = User.find_by(id: accounts.user_id)
		@invitations = Invitation.where(account_id: accounts.id).pluck(:user_id)
		@usr = User.where(id: [ @invitations, @owner].flatten)
		return @usr 
	end
end
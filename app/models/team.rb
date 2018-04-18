class Team < ApplicationRecord
	# has_many :messages
	#Methods for get_name and get_teaminfo method
	def self.create_team(account_id, namee, owner_id) 
		Team.create(account_id: account_id, name: namee, owner_id: owner_id)
	end	


	def self.create_team_users_by_modal(users_for_modal, team)
		users_for_modal.each do |id|
			@teamuser = Teamuser.create(team_id: team.id, user_id: id)
		end 
	end 
 
	#Methods for team show page
	def self.find_account(team)
		Account.find_by(id: team.account_id) 
	end
	def self.find_invited_users_for_modal(accounts, team)
		@usr = Array.new
		@owner = User.find_by(id: accounts.user_id)
		@usr.push(@owner)
		@invitations = Invitation.where(account_id: accounts.id)
		@invitations.each do |invi|
			if invi.user_id.present?
				@users = User.find_by(id: invi.user_id)
				@usr.push(@users)
			end
		end
		@usr
	end
	def self.find_teamusers_to_show(team)
      @teamusers = Teamuser.where(team_id: team.id)
      @usrr = []
      @teamusers.each do |id|
        @usrr  << User.find_by(id: id.user_id)
      end
    @usrr
    end
 
end

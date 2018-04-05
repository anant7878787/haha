class Team < ApplicationRecord

	#Methods for get_name and get_teaminfo method
	def self.create_team(account_id, namee)
		Team.create(account_id: account_id, name: namee)
	end	


	def self.find_team_users(ids, team)
		ids.each do |id|
		 	@teamuser = Teamuser.create(team_id: team.id, user_id: id)
		end 
	end

	#Methods for team show page
	def self.find_account(team)
		Account.find_by(id: team.account_id) 
	end
	def self.find_invited_users_for_modal(accounts, team)
		@usr = Array.new
		@invitations = Invitation.where(account_id: accounts.id)
		@invitations.each do |invi|
			if invi.user_id.present?
				@users = User.find_by(id: invi.user_id)
					if !Teamuser.find_by_user_id_and_team_id(@users.id, team.id)
						debugger
						@usr.push(@users)
					else
					end
			else
			end
		end
		@usr
	end
	def self.find_teamusers_to_show(teamuser, team)
		@usrr = Array.new
		teamuser.each do |tuser|
			@userrs = User.find_by(id: tuser.user_id)
				if team.id == tuser.team_id
					@usrr.push(@userrs)
				else
				end
		end 
		@usrr
	end
end

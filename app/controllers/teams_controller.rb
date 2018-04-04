class TeamsController < ApplicationController
	

	def get_name
		@name = valid_params[:name]
		@account_id = valid_params[:account_id]
		@team = Team.create(account_id: @account_id, name: @name)
		@teams = Team.all
		
		redirect_to account_path(@account_id)
	end

	def get_teaminfo
		@ids = params[:ids]
		@team = Team.find(params[:team][:team_id])
		@account_id = params[:account_id]
		@ids.each do |id|
		 	@teamuser = Teamuser.create(team_id: @team.id, user_id: id)
		end
	    redirect_to account_team_path(@account_id, @team.id)
	end
	def send_text
	end
	def show 
		@usrr = Array.new
		@usr = Array.new
		@team = Team.find(params[:id])
		@accounts = Account.find_by(id: @team.account_id)
		@invitations = Invitation.where(account_id: @accounts.id)
		@invitations.each do |invi|
		@users = User.find_by(id: invi.user_id)
			@usr.push(@users)
		end
		@teamuser = Teamuser.all
		@teamuser.each do |tuser|
			@userrs = User.find_by(id: tuser.user_id)
			if @team.id == tuser.team_id
			@usrr.push(@userrs)
		else
		end
		end
		
	end

	private
    def valid_params
        params.require(:team).permit(:name, :account_id, :user_id)
    end
end

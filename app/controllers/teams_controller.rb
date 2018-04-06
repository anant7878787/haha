class TeamsController < ApplicationController
	

	def get_name 
		@name = valid_params[:name]
		@account_id = valid_params[:account_id]
		@account = Account.find_by(id: @account_id)
		@owner_id = current_user.id
		@team = Team.create_team(@account_id, @name, @owner_id)
		@team_id = Team.last.id
		
		@teamuser = Teamuser.create(team_id: @team_id, user_id: current_user.id)
	
		redirect_to account_path(@account_id) 
	end

	def get_teaminfo 
		@ids = params[:ids]
		@team = Team.find(params[:team][:team_id])
		@account_id = params[:account_id]
		@teamuser = Team.find_team_users(@ids, @team)
		debugger
	    redirect_to account_team_path(@account_id, @team.id)
	end
	
	def show 
		@team = Team.find(params[:id])
		@accounts = Team.find_account(@team)
		@usr = Team.find_invited_users_for_modal(@accounts, @team)
		@teamuser = Teamuser.all
		@usrr = Team.find_teamusers_to_show(@teamuser, @team)
	end

	private
    def valid_params
        params.require(:team).permit(:name, :account_id, :user_id)
    end
end

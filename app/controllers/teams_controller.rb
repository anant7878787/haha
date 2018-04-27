class TeamsController < ApplicationController
	

	#getting team name, account id
	def get_name  
		@name = valid_params[:name] 
		@account_id = valid_params[:account_id]
		@account = Account.find_by(id: @account_id)
		# authorize Account
		@owner_id = current_user.id
		@team = Team.create(account_id: @account_id, name: @name, owner_id: @owner_id)
		@team_id = Team.last.id 
		@teamuser = Teamuser.create(team_id: @team_id, user_id: current_user.id)
		redirect_to account_path(@account_id) 
	end 
  
	def get_teaminfo   
		@users_for_modal = params[:user_ids_for_modal]
		@team = Team.find(params[:team][:team_id])
		# authorize Account
		@account_id = params[:account_id]
		@users_for_modal.each do |id| 
			@teamuser = Teamuser.create(team_id: @team.id, user_id: id)
		end
	    redirect_to account_team_path(@account_id, @team.id)
	end
	def show 
		@team = Team.find(params[:id])
		authorize @team, :show?
		@accounts = Account.find_by(id: @team.account_id) 
		#To show owner and invited users in modal
		@user_for_modal = @team.find_invited_users_for_modal(@accounts)
		# @teamuser = Teamuser.all
		#To show teamusers in table
		@usr_for_table = @team.find_teamusers_to_show
		@user_for_modal = @user_for_modal - @usr_for_table
		@messages = Message.where(team_id: @team.id)
	end

	private 
    def valid_params
        params.require(:team).permit(:name, :account_id, :user_id)
    end
end

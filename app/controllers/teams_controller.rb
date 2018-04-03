class TeamsController < ApplicationController
	

	def get_name
		
		@name = valid_params[:name]
		@account_id = valid_params[:account_id]
		@team = Team.create(account_id: @account_id, name: @name)
		@teams = Team.all
		
		redirect_to accounts_path
		
	end

	def get_teaminfo
		params[:checked]
		debugger
	end
	def send_text
	end
	def show 
		@usr = Array.new
		@team = Team.find(params[:id])
		@accounts = Account.find_by(id: @team.account_id)
		@invitations = Invitation.where(account_id: @accounts.id)
		@invitations.each do |invi|
		@users = User.find_by(id: invi.user_id)
			@usr.push(@users)
		end
	end

	private
    def valid_params
        params.require(:team).permit(:name, :account_id)
    end
end

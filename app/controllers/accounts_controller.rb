class AccountsController < ApplicationController


	def index 
        @accounts = Account.all_accounts_on_index(current_user)
    end
	
 
    def show  
        @account = Account.find(params[:id]) 
        @owner_name = @account.find_user_by_account
        @invited_users = @account.find_all_invited_members_by_invitations
        @teams = @account.find_myteam_by_account(current_user)
        @other_teams = @account.find_otherteam_by_account(@teams, current_user)
        @teamusers = Teamuser.all
    end

    def create
	   @account = Account.create(valid_params)
    end

    private
    def valid_params
        params.require(:account).permit(:account_name)
    end
end
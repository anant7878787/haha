class AccountsController < ApplicationController


	def index 
        #Redirecting to Account controller
        @accounts = Account.all_accounts_on_index(current_user)
    end
	
 
    def show 
        @account = Account.find(params[:id]) 
        @users = Account.find_user_by_account(@account) 
        @invitations = Account.search_in_invitations_by_account_id(@account)
        @usr = Account.find_all_invited_members_by_invitations(@invitations)
        @teams = Account.find_myteam_by_account(@account, current_user)
        @other_teams = Account.find_otherteam_by_account(@account, @teams, current_user)
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

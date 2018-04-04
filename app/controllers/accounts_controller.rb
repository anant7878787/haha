class AccountsController < ApplicationController


	def index
        @invited_accounts = Array.new
        @invitations = Invitation.where(user_id: current_user.id)
        @invitations.each do |invitation|
            account = Account.find_by(id: invitation.account_id)
            @invited_accounts.push(account)
        end
       @owner_accounts = Account.where(user_id: current_user.id)
       @accounts= @invited_accounts|@owner_accounts
    end
	

    def show
        
        @usr = Array.new
        @account = Account.find(params[:id])
        @users = User.find_by(id: @account.user_id)
        
        @invitations = Invitation.where(account_id: @account.id)
        @invitations.each do |inv|
          if inv.user_id.present?
            urs_id = inv.user_id
            user1 = User.find_by(id: urs_id)
            @usr.push(user1)
          else
          end
        end
        @teams = Team.where(account_id: @account.id)
       
    # @userdetails = User.where(id: @usr.user_id)
	   end

	def create
	   @account = Account.create(valid_params)
    end

    private
    def valid_params
        params.require(:account).permit(:account_name)
    end
end

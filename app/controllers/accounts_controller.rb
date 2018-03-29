class AccountsController < ApplicationController


	def index
	  @account = Account.where(user_id: current_user.id)
		user_id = current_user.id
    check_for_account = Account.find_by(user_id: user_id)
   
        if check_for_account == nil
        	@invitations = Invitation.where(user_id: user_id)
          @account = Array.new
          @invitations.each do |invitation|
            acc_id = invitation.account_id
            account = Account.find_by(id: acc_id)
            @account.push(account)
          end
        else	
          @account = Account.where(user_id: current_user.id)
		    end
	end

	def show
    @usr = Array.new
		@userdetails = Array.new
    @account = Account.find(params[:id])
		@users = Invitation.where(account_id: @account.id)
      @usr.push(@users)
      debugger

    @userdetails = User.where(id: @usr.user_id)
		
	end

	def create
	   @account = Account.create(valid_params)
    end

    private
    def valid_params
        params.require(:account).permit(:account_name)
    end
end

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
    @account = Account.find(params[:id])
		@invitations = Invitation.where(account_id: @account.id)
    @invitations.each do |inv|
      if inv.user_id.present?
        urs_id = inv.user_id
        user1 = User.find_by(id: urs_id)
        @usr.push(user1)
      else
      end
    end
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

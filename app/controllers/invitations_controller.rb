class InvitationsController < ApplicationController


	def get_user_mail 
        
        @email = valid_params[:user_email]
		@account_id = valid_params[:account_id]
        check = Invitation.check_for_user(@email)
        
        @i = Invitation.creating_users_in_invitation(check, @account_id, @email)
      
            if @i == true
                redirect_to accounts_path
            else
                redirect_to account_path(@account_id), alert: "This User is already exist in your team"
            end
    end
    
    def check_email 
        check = User.find_by(email: params[:user_email])
        email = params[:user_email]
        account_id = params[:account_id]
        if check == nil
    		redirect_to new_user_registration_path(emaill: email, acco_id: account_id)
    	else
    		redirect_to new_user_session_path
    	end
    end

    private
    def valid_params
        params.require(:invitation).permit(:user_email, :account_id)
    end
end

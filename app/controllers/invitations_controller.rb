class InvitationsController < ApplicationController


	def get_user_mail
		@email = valid_params[:user_email]
		@account_id = valid_params[:account_id]

        check = User.find_by(email: @email)
        
        if check == nil
            @invitation = Invitation.new(account_id: @account_id, user_email: @email)
            @invitation.save
        else
            @invitation = Invitation.new(account_id: @account_id, user_id: check.id, user_email: @email)
            @invitation.save
        end

	       UserMailer.invitation_send(@email, @account_id).deliver_now
	       redirect_to accounts_path
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

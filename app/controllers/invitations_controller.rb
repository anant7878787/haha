class InvitationsController < ApplicationController


	def get_user_mail
		@email = valid_params[:user_email]
		@account_id = valid_params[:account_id]
		debugger
	   UserMailer.invitation_send(@email, @account_id).deliver_now
	   redirect_to accounts_path
    end

    def check_email
    	check = User.find_by(email: params[:user_email])
    	if check = nil
    		redirect_to new_user_registration_path
    	else
    		redirect_to new_user_session_path
    	# if "http://localhost:3000/invitations/check_email?view=#{@user}" ==  
    	# 	redirect_to new_user_session_path
    	# else
    	# 	redirect_to new_user_registration_path
    	end
    end

    private
    def valid_params
        params.require(:invitation).permit(:user_email, :account_id)
    end
end

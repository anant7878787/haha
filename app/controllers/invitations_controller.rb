class InvitationsController < ApplicationController

 
	def get_user_mail 
         
        @email = valid_params[:user_email]
		@account_id = valid_params[:account_id]
        check_user = User.find_by(email: @email)
        @key = Digest::SHA1.hexdigest([@account_id, Time.now, rand].join)
        if check_user == nil
            @invitation = Invitation.create(account_id: @account_id, user_email: @email, key: @key)
            UserMailer.invitation_send(@email, @account_id, @key).deliver_now
             redirect_to accounts_path
        else  
            begin 
                @invitation = Invitation.create(account_id: @account_id, user_id: check_user.id, user_email: @email, key: @key)
                UserMailer.invitation_send(@email, @account_id, @key).deliver_now
               redirect_to accounts_path
            rescue
               redirect_to account_path(@account_id), alert: "This User is already exist in your team"
            end
        end
    end
    
    def check_email  
        check = User.find_by(email: params[:user_email])
        email = params[:user_email]
        account_id = params[:account_id]
        key = params[:key]
        if check == nil
    		redirect_to new_user_registration_path(emaill: email, acco_id: account_id, invited_key: key)
    	else
    		redirect_to new_user_session_path
    	end
    end
 
    private
    def valid_params
        params.require(:invitation).permit(:user_email, :account_id, :key)
    end
end

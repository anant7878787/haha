class ApplicationController < ActionController::Base
  	include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    # def pundit_user
    #   CurrentContext.new(current_user, record)
    # end
    
    protect_from_forgery with: :exception
  	before_action :configure_permitted_parameters, if: :devise_controller?
		def after_sign_in_path_for(resource)
      root_path
      	end
    def after_sign_out_path_for(resource)
      new_user_session_path
    end


    #redierting to signup page(without account name) through gmail
    def devise_redirect(token)
      redirect_to new_user_registration_path(invited_key: token), alert: "you have entered wrong entries"
    end
      helper_method :devise_redirect
     
     def pundit_user
        if params[:account_id].present?
          current_account = Account.find(params[:account_id])
        elsif params[:id].present?
          
        current_account = Account.find(params[:id])
      end
        AccountContext.new(current_user, current_account)
     end
 	protected 
 		def configure_permitted_parameters
   			devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :account_name, :check_account_id, :check_user_email, :key_for_invitation])
   			devise_parameter_sanitizer.permit(:account_update, keys: [:name, :account_name, :check_account_id, :check_user_email, :key_for_invitation])
 		end

    def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
 



class ApplicationController < ActionController::Base
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
     
 	protected 
 		def configure_permitted_parameters
   			devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :account_name, :check_account_id, :check_user_email, :key_for_invitation])
   			devise_parameter_sanitizer.permit(:account_update, keys: [:name, :account_name, :check_account_id, :check_user_email, :key_for_invitation])
 		end
end
 



# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  

  # def new

  #   @user = User.new
  #   # @account = @user.accounts.build
  # end

  # def create
  #   super 
  #   if params[:account_id].present?
  #     @acc_id = params[:account_id]
  #     @user = User.last 
  #     debugger
  #     @invitation = Invitation.where("account_id = ? AND user_email = ?", @acc_id, @user.email).update(user_id: @user.id)
  #   else
  #   end
  # end


  # If you have extra params to permit, append them to the sanitizer.
   # def configure_sign_up_params
   #   devise_parameter_sanitizer.permit(:sign_up, keys: [accounts_attributes: [:account_name]])
   # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

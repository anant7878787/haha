class AccountsController < ApplicationController


	def index
	   @account = Account.all
	end

	def create
	   @account = Account.create(valid_params)
    end

    private
    def valid_params
        params.require(:account).permit(:account_name)
    end
end

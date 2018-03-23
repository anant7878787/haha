class AccountsController < ApplicationController

debugger
	def index
		debugger
		@account = Account.all
	end

	def create
		debugger
        @account = Account.create(valid_params)
    end

    private
    def valid_params
    	debugger
        params.require(:account).permit(:account_name)
    end
end

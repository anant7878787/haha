class AccountContext
	attr_reader :user, :current_account

  def initialize(user, current_account)
    @user = user
    @current_account = current_account
  end
end 
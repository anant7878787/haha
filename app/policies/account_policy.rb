class AccountPolicy < ApplicationPolicy
  attr_reader :user, :account

  def show?
    if (@current_account.find_all_invited_members_by_invitations.include? @current_user) || (@current_account.user_id == @current_user.id)
      return true
    else
      return false
    end
  end 

  def send_mail?
  	if record.user_id == @current_user.id
  		return true
  	else
  		return false
  	end
  end
end
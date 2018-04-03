module ApplicationHelper
	 
	 def check_for_owner(user_id, account)
	 	if user_id == account.user_id
	 		
	 		return "owner"
	 	else
	 		return "member"
	 	end
	 end
	 def owner_name_for_card(account)
        @owner = User.find_by(id: account.user_id)
        return @owner.name
    end

end

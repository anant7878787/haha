module ApplicationHelper
	# def owner_for_member(user_id)
	# 	check = Account.find_by(user_id: user_id)
	# 	if check == nil
	# 		return member
	# 	else
	# 		return owner
	# 	end
	# end

	def check_for_add_users(user_id)
		check = Account.find_by(user_id: user_id)
		if check == nil
			return false
      	else
      		return true
      	end
	end
end

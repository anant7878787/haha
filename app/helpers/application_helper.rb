module ApplicationHelper
	 
	 def check_for_owner(user_id, account)

	 	if user_id == account.user_id
	 		return "owner"
	 	else
	 		return "member"
	 	end
	 end
	  
	  def owner_name_for_team(team_id)
	  
         @owner = User.find_by(id: team_id)
         return @owner.name
     end
end




	def check_for_owner_add_member(user_id, team_id)

	 	if Team.find_by(owner_id: user_id, id: team_id).present?
	 		
	 		return "owner"
	 	else
	 		
	 		return "member"
	 	end
	end

	
class Account < ApplicationRecord
  validates :account_name, :user_id, presence: true
  
    #this method finding account owner name(To show on account show page) through user table
    #we
    def find_user_by_account 
      return User.find(user_id)
    end 
    #i bind two functions into one(search_in_invitation_by_account_id into this function), 
    #first function(s_i_i_b_a) finding invitations for that account and by using those 
    #invitations we are finding invited users info to show on show page.
    def find_all_invited_members_by_invitations
      @invited_users_ids = Invitation.where(account_id: id).pluck(:user_id) 
      @usr = User.where(id: [@invited_users_ids])
      return @usr     
    end


    #finding myteams(which are created by account owner)
    def find_myteam_by_account(b)
      return @teams = Team.where("account_id = ? AND owner_id = ?" , id , b).to_a
    end

    #finding otherteams(which are created by invited users of that account_owner)
    def find_otherteam_by_account(teams , current_user)
      @all_teams = Team.where(account_id: id)
      other_teams = @all_teams - teams
      @other_teams = []
      other_teams.each do |team|
        if Teamuser.find_by("team_id = ? AND user_id = ?" , team.id , current_user.id).present?
          @other_teams.push(team)
        end
      end
        return @other_teams 
    end


  class << self
    #Method for index page
    def all_accounts_on_index(current_user) 
      invitations = Invitation.where(user_id: current_user.id).pluck(:account_id)
      owner_accounts = Account.where(user_id: current_user.id).pluck(:id) 
      @accounts = Account.where(id: [ invitations, owner_accounts].flatten)
    end
  end
end
     




    #Method for show page
   
    
 
    # def myteam_owner_name(teams)
    #   owner_name = []
    #   teams.each do |mt|
    #     u = User.find(mt.owner_id)
    #     owner_name.push(u)
    #   end
    #   owner_name

    #   debugger
    # end


    # def find_owner_name_of_team(teams)
    #   debugger
    # end




  # class << self
  # 	def invitation_user(user)
  # 		Invitation.where(user_id: user.id)
  # 	end
  # 	def current_account(acc_id)
  # 		Account.find(acc_id) 
  # 	end

  # 	def owner_acc(user)
  # 		Account.where(user_id: user.id)
  # 	end

  # 	def inv_accounts(user)
  # 		inv_acc=[]
  # 		invitation_user(user).each do |i|
  # 			inv_acc.push(i.account_id)
  # 		end
  # 	end

  # 	def all_accounts(user)
  # 		@accounts = inv_accounts(user) | owner_acc(user)
  # 	end
  # end


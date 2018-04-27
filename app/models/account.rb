class Account < ApplicationRecord
  validates :account_name, :user_id, presence: true
  has_many :comments, as: :commentable
    def find_user_by_account 
      return User.find(user_id)
    end  
    def find_all_invited_members_by_invitations
      @invited_users_ids = Invitation.where(account_id: id).pluck(:user_id) 
      @usr = User.where(id: [@invited_users_ids])
      return @usr     
    end 
    def find_myteam_by_account(current_user)
      return @teams = Team.where("account_id = ? AND owner_id = ?" , id , current_user).to_a
    end
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
    def all_accounts_on_index(current_user) 
      invitations = Invitation.where(user_id: current_user.id).pluck(:account_id)
      owner_accounts = Account.where(user_id: current_user.id).pluck(:id) 
      @accounts = Account.where(id: [ invitations, owner_accounts].flatten)
    end
  end
end
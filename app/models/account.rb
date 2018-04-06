class Account < ApplicationRecord
  

    #Method for index page
    def self.all_accounts_on_index(current_user)
      @invited_accounts = Array.new
      @invitations = find_user_by_invitation(current_user)
      @owner_accounts = find_accounts_for_owner(current_user)

      @invitations.each do |invitation|
        account = Account.find_by(id: invitation.account_id)
        @invited_accounts.push(account)
      end
      @accounts = all_accounts(@invited_accounts, @owner_accounts)
    end

    #Method for show page
    def self.find_user_by_account(account) 
       User.find_by(id: account.user_id)
    end

    def self.search_in_invitations_by_account_id(account)
        Invitation.where(account_id: account.id)
    end


    def self.find_all_invited_members_by_invitations(invitations)
      @usr = Array.new 
      invitations.each do |inv|
          if inv.user_id.present?
            urs_id = inv.user_id
            user1 = User.find_by(id: urs_id)
            @usr.push(user1)
          else
          end
      end
       @usr
    end

    def self.find_myteam_by_account(account, current_user)
      
      Team.where("account_id = ? AND owner_id = ?" , account.id , current_user.id).to_a
      
      
    end

    def self.find_otherteam_by_account(account, teams , current_user)
      
      @other_teams = Team.where(account_id: account.id)
      
      other_teams = @other_teams - teams
      @other_teams = []

      other_teams.each do |team|
        if Teamuser.find_by("team_id = ? AND user_id = ?" , team.id , current_user.id).present?
          @other_teams.push(team)
        end
      end
        @other_teams
    end

 















    #Sub methods for index page

    def self.find_user_by_invitation(current_user)
      Invitation.where(user_id: current_user.id)
    end

    def self.find_accounts_for_owner(current_user)
      Account.where(user_id: current_user.id)
    end

    def self.all_accounts(invited_accounts, owner_accounts)
      @invited_accounts|@owner_accounts
    end



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
end
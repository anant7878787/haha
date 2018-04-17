require 'rails_helper'

RSpec.describe Team, type: :model do

    #team show page methods
    #find account
    it "find account" do
      owner = FactoryGirl.create(:user)
      account = Account.create(account_name: "Maropost" , user_id: owner.id)
      @team = Team.create(name: "QA", account_id: account.id, owner_id: owner.id)
      account = Account.find_by(id: @team.account_id)
      @account = Team.find_account(@team)
      expect(@account).to eq(account)
    end

    #find users(owner, invited users for modal)
    it "find invited users for modal" do
      owner = FactoryGirl.create(:user)
      account = Account.create(account_name: "Maropost" , user_id: owner.id)
      member = FactoryGirl.create(:user)
      @team = Team.create(name: "QA", account_id: account.id, owner_id: owner.id)
      invitation = Invitation.create(account_id: account.id, user_id: member.id, user_email: member.email, key: "1f638b18fd1946a0e7274363b929123fdbf98f8a29")
      modal_users = []
      modal_users << owner 
      modal_users << member
      @modal_users = Team.find_invited_users_for_modal(account, @team)
      expect(@modal_users).to eq(modal_users)
    end

    it "find_teamusers_to_show_in_tables" do
      owner = FactoryGirl.create(:user)
      account = Account.create(account_name: "Maropost" , user_id: owner.id)
      member = FactoryGirl.create(:user)
      @team = Team.create(name: "QA", account_id: account.id, owner_id: owner.id)
      @team_user = []
      users_to_show = []
      @team_user << Teamuser.create( team_id: @team.id, user_id: owner.id)
      users_to_show  << User.find_by(id: @team_user.first.user_id)
      @users_to_show = Team.find_teamusers_to_show(@team)
      expect(@users_to_show).to eq(users_to_show)
    end
end 
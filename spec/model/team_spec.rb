require 'rails_helper'

RSpec.describe Team, type: :model do
  before :each do
    @owner = create :user
    @owner_account = create :account , user_id: @owner.id
    @member = create :user
    @member_account = create :account , user_id: @member.id
  end
  

    #find users(owner, invited users for modal)
    it "find invited users for modal" do
      @team = Team.create(name: "QA", account_id: @owner_account.id, owner_id: @owner.id)
      invitation = Invitation.create(account_id:  @owner_account.id, user_id: @member.id, user_email: @member.email, key: "1f638b18fd1946a0e7274363b929123fdbf98f8a29")
      modal_users = []
      modal_users << @owner 
      modal_users << @member
      @modal_users = @team.find_invited_users_for_modal(@owner_account)
      expect(@modal_users).to eq(modal_users)
    end

    it "find_teamusers_to_show_in_tables" do
       @team = Team.create(name: "QA", account_id: @owner_account.id, owner_id: @owner.id)
       @team_user = []
       users_to_show = []
       @team_user << Teamuser.create( team_id: @team.id, user_id: @owner.id)
       users_to_show  << User.find_by(id: @team_user.first.user_id)
       @users_to_show = @team.find_teamusers_to_show
      debugger
       expect(@users_to_show).to eq(users_to_show)
    end
end 
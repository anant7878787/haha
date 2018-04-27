require 'rails_helper'

RSpec.describe Team, type: :model do
  before :each do
    @owner = create :user
    @owner_account = create :account , user_id: @owner.id
    @member = create :user
    @member_account = create :account , user_id: @member.id
  end
  
  describe ".find_teamusers_to_show" do
    it "find_teamusers_to_show_in_tables" do
      @team = (create :team , owner_id: @owner.id , account_id: @owner_account.id)
      Teamuser.create(team_id: @team.id , user_id: @owner.id)
      Teamuser.create(team_id: @team.id , user_id: @member.id)
      users_to_show = []
      users_to_show << @owner
      users_to_show << @member
      @users_to_show = @team.find_teamusers_to_show
      expect(@users_to_show).to eq(users_to_show)
    end

     it "should returns an empty object if their is no member in team" do
      @team = (create :team , owner_id: @owner.id , account_id: @owner_account.id)
      @users = []
      users = @team.find_teamusers_to_show
      expect(@users).to eq(users)
    end
  end
    #find users(owner, invited users for modal)
  describe ".find_invited_users_for_modal(@owner_account)" do 
    it "find invited users for modal" do
      @team = Team.create(name: "QA", account_id: @owner_account.id, owner_id: @owner.id)
      invitation = Invitation.create(account_id:  @owner_account.id, user_id: @member.id, user_email: @member.email, key: "1f638b18fd1946a0e7274363b929123fdbf98f8a29")
      modal_users = []
      modal_users << @owner 
      modal_users << @member
      @modal_users = @team.find_invited_users_for_modal(@owner_account)
      expect(@modal_users).to eq(modal_users)
    end
  end
   
end 


 

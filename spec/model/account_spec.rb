require 'rails_helper'

RSpec.describe Account, type: :model do

  	#checking whether show page getting owner name
    describe ".find_user_by_account(account)" do
      it "Testing whether owner name showing on show page or not" do
      	user = FactoryGirl.create(:user)
        account = Account.create(account_name: "Maropost" , user_id: user.id)
        # @users = User.find_by(id: account.user_id)
     	  users = Account.find_user_by_account(account)
     	  expect(users).to eq(user)
      end

    #checking whether show page not getting owner name
      it "when the current user is not owner" do
        user = FactoryGirl.create(:user)
        member = FactoryGirl.create(:user)
        account = Account.create(user_id: user.id)
        return_users = Account.find_user_by_account(account)
        expect(return_users).not_to eq(member)
      end
    end

    #Checking whether any invited user present in Invitation table through account_id
    describe ".search_in_invitations_by_account_id" do
      it "Testing whether any invited user present" do
       	user = FactoryGirl.create(:user)
        account = Account.create(account_name: "Maropost" , user_id: user.id)
        invitation = Invitation.create(account_id: account.id, user_id: "2", user_email: "gurjot21@gmail.com", key: "1f638b181946a0e7274363b929123fdbf98f8a29")
  	  	@invitations = Invitation.where(account_id: account.id)
  		  invitations = Account.search_in_invitations_by_account_id(account)
  	  	expect(@invitations).to eq(invitations)
  	  end

      #checking when invitations are not present
      it "Testing when invited user is not present" do  
        owner = FactoryGirl.create(:user)
        account = Account.create(account_name: "Maropost" , user_id: owner.id)
        another_owner = FactoryGirl.create(:user)
        another_owner_account = Account.create(account_name: "Flipkart" , user_id: another_owner.id)
        invitation = Invitation.create(account_id: account.id, user_id: "2", user_email: "gurjot21@gmail.com", key: "aaaaaa8b18")
        invitation = Invitation.create(account_id: another_owner_account.id, user_id: "3", user_email: "gj31@gmail.com", key: "1f638b18194")
        @invitations = Invitation.where(account_id: another_owner_account.id)
        invitations = Account.search_in_invitations_by_account_id(account)
        expect(@invitations).not_to eq(invitations)
      end
    end


    #checking when invited user not present in Invitation table
  
      it "Testing whether any invited user present" do
      user = FactoryGirl.create(:user)
      account = Account.create(account_name: "Maropost" , user_id: user.id)
      invitation = Invitation.create(account_id: account.id, user_id: "2", user_email: "gurjot21@gmail.com", key: "1f638b181946a0e7274363b929123fdbf98f8a29")
      @invitations = Invitation.where(account_id: account.id)
      invitations = Account.search_in_invitations_by_account_id(account)
      expect(@invitations).to eq(invitations)
    end






    #Checking whether getting user details or not
  	describe ".find_all_invited_members_by_invitations(invitations)" do
      it "Getting user details from invitation all having user_id" do
    		owner = FactoryGirl.create(:user)
    		account = Account.create(account_name: "Maropost" , user_id: owner.id)
    		member = FactoryGirl.create(:user)
    		invitation = Invitation.create(account_id: account.id, user_id: member.id, user_email: member.email, key: "1f638b18fd1946a0e7274363b929123fdbf98f8a29")
    		invitations = Invitation.all
    		usr = []
        usr << member
    		usrs = Account.find_all_invited_members_by_invitations(invitations)
    		expect(usrs).to eq(usr)
    	end
      
      #failure case
       it "not getting user details because invitations are not present" do
         owner = FactoryGirl.create(:user)
         account = Account.create(account_name: "Maropost" , user_id: owner.id)
         invit = []         
         usrs = Account.find_all_invited_members_by_invitations(invit)
         expect(usrs).to eq([])
       end
       #getting users who have 
       it "invitations are present with and without user_id" do
        owner = FactoryGirl.create(:user)
        account = Account.create(account_name: "Maropost" , user_id: owner.id)
        member = FactoryGirl.create(:user)
        invitation = Invitation.create(account_id: account.id, user_id: member.id, user_email: member.email, key: "1f638b18fd1946a0e7274363b929123fdbf98f8a29")
        invitation2 = Invitation.create(account_id: account.id, user_email: "abc@gmail.com", key: "1f638b18fd1946a0e7274363b23fdbf98f8afdbfdb")
        usr = []
        usr << member
        invitations = Invitation.all
        usrs = Account.find_all_invited_members_by_invitations(invitations)
        expect(usrs).to eq(usr)   
       end
    end

	  

    #Checking whether current_user's teams(myteams) available or not
  	describe ".find_myteam_by_account(account, owner.id)" do
      it "Getting current_user teams" do
    		owner = FactoryGirl.create(:user)
    		account = Account.create(account_name: "Maropost" , user_id: owner.id)
    		member = FactoryGirl.create(:user)
    		invitation = Invitation.create(account_id: account.id, user_id: member.id, user_email: member.email, key: "1f638b18fd1946a0e7274363b929123fdbf98f8a29")
    	  	@team = []
    	  	@team << Team.create(account_id: account.id, owner_id: owner.id, name: "Developer")
    		team = Account.find_myteam_by_account(account, owner.id)
    	    expect(@team).to eq(team)
    	end

      #failure case
      # it "" do 
      # end



  	#Checking whether current_user getting other teams(created by other users) or not
  	it "Getting current_user's other_teams" do
  		owner = FactoryGirl.create(:user)
  		account = Account.create(account_name: "Maropost" , user_id: owner.id)
  		member = FactoryGirl.create(:user)
  		invitation = Invitation.create(account_id: account.id, user_id: member.id, user_email: member.email, key: "1f638b18fd1946a0e7274363b929123fdbf98f8a29")
  	  	@team = []
  	  	@team << Team.create(account_id: account.id, owner_id: owner.id, name: "Developer")
  	 	@other_team = []
  	 	@other_team << Team.create(account_id: account.id, owner_id: member.id, name: "Tester" )
  	 	@team_user = []
  	 	@team_user << Teamuser.create( team_id: @other_team.first.id, user_id: member.id)
  	 	other_team = Account.find_otherteam_by_account(account, @team, member)
  	 	expect(@other_team).to eq(other_team)
  	end



end
	# context 'validations' do
  	#   it { should validate_presence_of :email }
  	#   it { should validate_presence_of :password }
  	#   it { should validate_confirmation_of :password }
  	#   it { should validate_uniqueness_of(:email).case_insensitive }
  	# end

    # it "Allows creation of individual user" do
    #     user = FactoryGirl.create(:user)
    #     debugger
    # end
     
    
	#creating account with single account entry
	# failure, if account name and user id are same
	# it "Allows creation of individual account" do
 	#        # account = FactoryGirl.create(:account)
 	#       	# debugger  
 	#    end


    # it "The owner_of_account method should returns an user object" do
    #    user = create :user
    #    account = Account.create(account_name: "Maropost" , user_id: user.id)
    #    owner = Account.owner_of_account(account)
    #    debugger
    #    expect(owner.id).to eq(account.user_id)
    # end








      # it "The find_user method should return an name" do
      #     ac = User.find_user('anants70000007@gmail.com')
      #       debugger
      #     expect(ac).to be_an_instance_of(Array)
      # end


  # "The users_in_accounts method should returns an user object from particular account" do
   #    owner = create :user
   #    account = Account.create(account_name: "Flipkart" , user_id: owner.id)
   #    member = create :user
   #    users_in_account = Invitation.create(email: "gurjot@gmail.com" , account_id: account.id , user_id: member.id , key: "abcdefgh")
   #    users =[]
   #    users << owner
   #    users << User.find_by(id: users_in_account.user_id)
   #    returned_users = Account.users_in_accounts(account)
   #    expect(users).to eq(returned_users)
   #   end































































# require 'rails_helper'

# RSpec.describe Account, type: :model do
#   it { is_expected.to validate_presence_of(:account_name)}

#       describe ".find_myteam_by_account(a, b)" do
#     	a = 18
#     	b = 25
#     	Account.find_myteam_by_account(a, b) 
#         team = Team.first
#         debugger
#     	expect(team.account_id).to eq(a)
#     	expect(team.owner_id).to eq(b)
#     end 
# end

  # it "the all_invited_members_by_invitations should return array" do
  # 	ac = Account.find_all_invited_members_by_invitations(1)
  # 	expect(ac).to be_an_instance_of(Array)  
  # end






# def self.create_and_request_confirmation(params)
#     transaction do
#       subscription = create!(
#         email: params[:email],
#         start_on: params[:start_on],
#         confirmation_token: generate_confirmation_token
#       )
#       SubscriptionMailer.send_confirmation_request!(subscription)
#       subscription
#     end
#   end

  

#   describe ".create_and_request_confirmation(params)" do

#     it "creates an unconfirmed subscription with the given params" do
#       params = { email: "subscriber@somedomain.tld", start_on: "2015-01-31" }
#       Subscription.create_and_request_confirmation(params)

#       subscription = Subscription.first

#       expect(subscription.confirmed?).to eq(false)
#       expect(subscription.email).to eq(params[:email])
#       expect(subscription.start_on).to eq(Date.new(2015, 1, 31))
#     end

    
#      def find_myteam_by_account(account, current_user)
      
#       @teams = Team.where("account_id = ? AND owner_id = ?" , account.id , current_user.id).to_a
      
      
#     end

   

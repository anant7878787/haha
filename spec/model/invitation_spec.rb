require 'rails_helper'

RSpec.describe Invitation, type: :model do

	it "Checking for email is present or not in user" do
		owner = FactoryGirl.create(:user)
    	account = Account.create(account_name: "Maropost" , user_id: owner.id)
     	member = FactoryGirl.create(:user)
     	# invitation = Invitation.create(account_id: account.id, user_id: member.id, user_email: member.email, key: "1f638b18fd1946a0e7274363b929123fdbf98f8a29")
		check_user = nil
	 	debugger
	 	invitation = Invitation.create(account_id: account.id, user_email: "an@gmail.com", key:"1hbhhhfbjh3jjnb333km")
	 	# invitation = Invitation.check_for_user(email)
	 	 UserMailer.invitation_send(invitation.u, account_id, key).deliver_now
	 	debugger
	 	@invitation = Invitation.creating_users_in_invitation(check_user, account.id, "an@gmail.com", "1hbhhhfbjh3jjnb333km") 
	 	# expect(invitation.email).to eq("gn77@gmail.com")
	 	debugger
	end
end




















































# require 'rails_helper'

# # RSpec.describe Invitation, type: :model do
# #   expect { 
# #   post :create, :user => {:user => :attributes }
# # }.to change { User.count }
# # end




# describe 'POST #create' do

#     it "creates a invitation" do

#       post :create, :invitation => { account_id: "18"}

#       #returns true if the post was successfully added
#       expect(Invitation.where(account_id: "18")).to be_present
#     end
#   end

#   it "the owner_of_account should return array" do
#   	ac = Account.find_all_invited_members_by_invitations(1)
#   	expect(ac).to be_an_instance_of(Array)
#   end










#   def self.create_and_request_confirmation(params)
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
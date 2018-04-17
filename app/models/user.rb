class User < ApplicationRecord
	 attr_accessor :account_name, :check_account_id, :check_user_email, :key_for_invitation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :accounts, dependent: :destroy 
    has_many :messages
 	#validates :email, :password, presence: true
  validates :name, presence: true
 	def self.find_user(email) 
      ac = User.find_by_email(email)
    return ac 
  end
 

	after_create :create_user 
 	
  private
 	def create_user 
 		
 		if key_for_invitation.present?
 			@invitation = Invitation.where("key = ?", key_for_invitation).update(user_id: self.id)
 		else
   		Account.create(user_id: self.id , account_name: account_name)
 	end
 	end	
end 
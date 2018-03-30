class User < ApplicationRecord
	 attr_accessor :account_name, :account_id1, :user_email1
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :accounts, dependent: :destroy 
   
 	#validates :email, :password, presence: true

	after_create :create_user
 	private
 	def create_user
 		 
 		if account_id1.present? && user_email1.present?
 			@invitation = Invitation.where("account_id = ? AND user_email = ?", account_id1, user_email1).update(user_id: self.id)
 		else
   		Account.create(user_id: self.id , account_name: account_name)
 	end
 	end	
end 
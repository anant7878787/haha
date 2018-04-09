class User < ApplicationRecord
	 attr_accessor :account_name, :check_account_id, :check_user_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :accounts, dependent: :destroy 
   
 	#validates :email, :password, presence: true

	after_create :create_user 
 	private
 	def create_user
 		 debugger
 		if check_account_id.present? && check_user_email.present?
 			@invitation = Invitation.where("account_id = ? AND user_email = ?", check_account_id, check_user_email).update(user_id: self.id)
 		else
   		Account.create(user_id: self.id , account_name: account_name)
 	end
 	end	
end 
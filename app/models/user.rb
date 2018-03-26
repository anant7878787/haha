class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :accounts, dependent: :destroy 
    accepts_nested_attributes_for :accounts
 	#validates :email, :password, presence: true


 	after_create :populate_invites

	def populate_invites
	end 	
end

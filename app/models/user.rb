class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :accounts, dependent: :destroy 
    accepts_nested_attributes_for :accounts, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
 	#validates :email, :password, presence: true
end

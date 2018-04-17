 FactoryGirl.define do
   factory :user do
    
     name {Faker::Name.name}
     email {Faker::Internet.email}
     password 'Anant123'
   end
 end

 
  # factory :user do
    
  #    name 'Anant' {Faker::Name.name}
  #    email  'anant77@gmail.com' {Faker::Internet.email}
  #    password 'Anant123'
  #  end
# FactoryGirl.define do
#   factory :account do
# 	account_name 'Maropost'
# 	user_id  '7'
#    end
# end
  

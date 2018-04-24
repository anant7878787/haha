FactoryGirl.define do
	factory :account do
		account_name {Faker::Name.name}
	end
end
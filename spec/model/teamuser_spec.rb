require 'rails_helper'

RSpec.describe Teamuser, type: :model do
    it "Allows creation of individual teamuser" do
           teamuser = FactoryGirl.create(:teamuser)
         debugger
    end
end 
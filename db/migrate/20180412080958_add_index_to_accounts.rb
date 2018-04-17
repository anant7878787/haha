class AddIndexToAccounts < ActiveRecord::Migration[5.1]
  def change
  end
  add_index :accounts,[:user_id, :account_name], unique:true
end

class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.integer :account_id      , null:false
      t.integer :user_id
    end
      add_index :invitations,[:user_email, :account_id], unique:true
  end
end

class AddKeyToInvitations < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :key, :string
  end
end

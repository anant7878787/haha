class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :account_name
      t.integer :owner_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

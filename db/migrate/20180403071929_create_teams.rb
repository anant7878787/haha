class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :account_id
      t.integer :owner_id

      t.timestamps
    end
  end
end

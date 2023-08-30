class CreateTeamsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :teams_users do |t|
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :admin,   default: false

      t.timestamps
    end
    add_index :teams_users, [:team_id, :user_id], unique: true, name: "team_members"
  end
end

class CreateTeamsPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :teams_permissions do |t|
      t.references :team, null: false, foreign_key: true
      t.references :permittable, null: false, polymorphic: true

      t.timestamps
    end

    add_index :teams_permissions, [:team_id, :permittable_id, :permittable_type], unique: true, name: "team_permitted"
  end
end

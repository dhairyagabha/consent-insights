class CreateVisits < ActiveRecord::Migration[7.0]
  def change
    create_table :visits do |t|
      t.string :visit_id,     null: false
      t.references :property, null: false, foreign_key: true
      t.string :country,      null: false, limit: 4
      t.string :language,     null: false, limit: 4
      t.string :user_type,    null: false, default: "NEW"
      t.string :preferences,  limit: 10
      t.string :user_agent
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end

class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name,     null: false
      t.string :domain
      t.string :api_key,  null: false, unique: true
      t.string :secret,   null: false, unique: true

      t.timestamps
    end
  end
end

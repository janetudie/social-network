class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :blurb
      t.references :user

      t.timestamps null: false
    end
  end
end

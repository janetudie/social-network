class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
    	t.references :likeable, polymorphic: true, index: true
    	t.integer :liker_id
      t.timestamps null: false
    end
  end
end

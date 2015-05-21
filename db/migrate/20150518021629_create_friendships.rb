class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
    	t.references :user, :friend
			t.boolean :approved

      t.timestamps null: false
    end
  end
end

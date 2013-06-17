class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.string :content
      t.integer :upvote
      t.integer :hit
      t.integer :user_id

      t.timestamps
    end

    add_index :posts, [:user_id, :upvote, :hit]
  end
end

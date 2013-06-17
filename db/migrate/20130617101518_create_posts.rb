class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.string :content
      t.integer :upvote, default: 1
      t.integer :hit, default: 0
      t.integer :user_id

      t.timestamps
    end

    add_index :posts, [:user_id, :upvote, :hit]
  end
end

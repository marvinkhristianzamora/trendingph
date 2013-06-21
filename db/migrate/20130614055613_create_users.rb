class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, unique: true
      t.string :password_digest
      t.string :email, unique: true
      t.integer :karma
      t.string :remember_token
      t.boolean :admin, default: false


      t.timestamps
    end

    add_index :users, [:username, :remember_token]
  end
end

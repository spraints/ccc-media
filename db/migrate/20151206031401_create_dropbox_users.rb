class CreateDropboxUsers < ActiveRecord::Migration
  def change
    create_table :dropbox_users do |t|
      t.string :uid
      t.string :email
      t.string :token

      t.timestamps null: false
    end
    add_index :dropbox_users, :uid
    add_index :dropbox_users, :email
  end
end

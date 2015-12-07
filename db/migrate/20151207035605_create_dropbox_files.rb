class CreateDropboxFiles < ActiveRecord::Migration
  def change
    create_table :dropbox_files do |t|
      t.string :category
      t.string :path
      t.string :date
      t.string :public_url
      t.timestamp :public_url_expires_at
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end

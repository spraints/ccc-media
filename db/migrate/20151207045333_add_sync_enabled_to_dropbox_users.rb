class AddSyncEnabledToDropboxUsers < ActiveRecord::Migration
  def change
    add_column :dropbox_users, :sync_enabled, :boolean
  end
end

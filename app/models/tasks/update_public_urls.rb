module Tasks
  class UpdatePublicUrls
    def perform(uid)
      user = DropboxUser.for_uid!(uid)
      return unless user.sync_enabled?
      user.files.expired.each do |file|
        shared = user.dropbox_client.create_shared_link_with_settings(file.path)
        p shared
        file.public_url = shared.url
        file.public_url_expires_at = shared.expires
        file.save!
      end
    end
  end
end

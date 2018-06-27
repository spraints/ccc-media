module Tasks
  class UpdatePublicUrls
    def perform(uid)
      user = DropboxUser.for_uid!(uid)
      return unless user.sync_enabled?
      client = user.dropbox_client
      user.files.expired.each do |file|
        current_links = client.list_shared_links(path: file.path).links
        shared = current_links.select { |link| link.is_a?(DropboxApi::Metadata::FileLink) }.first
        shared ||= client.create_shared_link_with_settings(file.path)
        p shared
        file.public_url = shared.url
        file.public_url_expires_at = shared.expires
        file.save!
      end
    end
  end
end

module Tasks
  class UpdateBulletins
    def perform(uid)
      user = DropboxUser.for_uid!(uid)
      bulletins = Tasks::ListBulletins.new.perform(uid)
      bulletins.each do |info|
        file = user.files.in_category("bulletin").at_path(info[:path])
        file.date = info[:date]
        file.save!
      end
      Tasks::UpdatePublicUrls.new.perform(uid)
    end
  end
end

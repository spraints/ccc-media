module Tasks
  class ListBulletins
    def perform(uid)
      user = DropboxUser.for_uid(uid)
      client = DropboxClient.new(user.token)
      [client.account_info]
    end
  end
end

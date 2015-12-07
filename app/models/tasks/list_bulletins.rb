module Tasks
  class ListBulletins
    def perform(uid)
      user = DropboxUser.for_uid(uid).first!
      client = DropboxClient.new(user.token)
      find_bulletins client, "/Misc"
    end

    def find_bulletins(client, path, result = [])
      client.metadata(path).fetch("contents").each do |meta|
        if meta["is_dir"]
          find_bulletins(client, meta["path"], result)
        elsif File.basename(meta["path"]) =~ /^bulletin/
          result << meta
        end
      end
      result
    end
  end
end

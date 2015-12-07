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
          result.push info(client, meta)
        end
      end
      result
    end

    def info(client, meta)
      info = {}
      info[:name] = File.basename(meta["path"])
      info[:date] =
        if info[:name] =~ /(\d\d)(\d\d)(\d\d)/
          Date $3.to_i + 2000, $1.to_i, $2.to_i
        end
      info[:url] = client.shares(meta["path"]).fetch("url")
      info
    end
  end
end

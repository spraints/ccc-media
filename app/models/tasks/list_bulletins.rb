module Tasks
  class ListBulletins
    def perform(uid)
      user = DropboxUser.for_uid!(uid)
      find_bulletins user.dropbox_client, "/Misc"
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
      info[:path] = meta["path"]
      info[:name] = File.basename(meta["path"])
      info[:date] =
        if info[:name] =~ /(\d\d)(\d\d)(\d\d)/
          Date.new $3.to_i + 2000, $1.to_i, $2.to_i
        end
      info
    end
  end
end

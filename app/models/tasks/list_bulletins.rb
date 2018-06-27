module Tasks
  class ListBulletins
    def perform(uid)
      user = DropboxUser.for_uid!(uid)
      find_bulletins user.dropbox_client, "/Misc"
    end

    def find_bulletins(client, path, result = [])
      client.list_folder(path).entries.each do |entry|
        case entry
        when DropboxApi::Metadata::Folder
          find_bulletins(client, entry.path_lower, result)
        when DropboxApi::Metadata::File
          if entry.name =~ /^bulletin/i
            result.push info(client, entry)
          end
        end
      end
      result
    end

    def info(client, file)
      info = {}
      info[:path] = file.path_display
      info[:name] = file.name
      info[:date] =
        if info[:name] =~ /(\d\d)(\d\d)(\d\d)/
          Date.new $3.to_i + 2000, $1.to_i, $2.to_i
        end
      info
    end
  end
end

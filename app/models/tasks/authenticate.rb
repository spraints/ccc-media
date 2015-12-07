module Tasks
  class Authenticate
    def perform(auth_hash)
      uid = auth_hash.uid
      email = auth_hash.info.email
      token = auth_hash.credentials.token

      dbu = DropboxUser.for_uid(uid).first_or_initialize
      dbu.email = email
      dbu.token = token
      dbu.save!
      dbu
    end
  end
end

module Tasks
  class Authenticate
    def perform(auth_hash)
      uid = auth_hash.extra.raw_info.account_id
      email = auth_hash.info.email
      token = auth_hash.credentials.token

      dbu = DropboxUser.for_email(email).first_or_initialize
      dbu.uid = uid
      dbu.token = token
      dbu.save!
      dbu
    end
  end
end

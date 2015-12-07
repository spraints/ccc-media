class DropboxUser < ActiveRecord::Base
  has_many :files, class_name: "DropboxFile", foreign_key: "owner_id"
  scope :for_uid, ->(uid) { where(:uid => uid) }

  def self.for_uid!(uid)
    for_uid(uid).first!
  end

  def dropbox_client
    DropboxClient.new(token)
  end
end

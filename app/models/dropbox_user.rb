class DropboxUser < ActiveRecord::Base
  has_many :files, class_name: "DropboxFile", foreign_key: "owner_id"
  scope :for_uid, ->(uid) { where(:uid => uid) }
  scope :for_email, ->(email) { where(:email => email) }

  def self.for_uid!(uid)
    for_uid(uid).first!
  end

  def self.for_email!(email)
    for_email(email).first!
  end

  def dropbox_client
    DropboxApi::Client.new(token)
  end
end

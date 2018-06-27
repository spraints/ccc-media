class DropboxUser < ActiveRecord::Base
  has_many :files, class_name: "DropboxFile", foreign_key: "owner_id"
  scope :for_email, ->(email) { where(:email => email) }

  def self.for_email!(email)
    for_email(email).first!
  end

  def dropbox_client
    DropboxClient.new(token)
  end
end

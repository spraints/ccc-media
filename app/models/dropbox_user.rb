class DropboxUser < ActiveRecord::Base
  has_many :files, class_name: "DropboxUser", foreign_key: "owner_id"
  scope :for_uid, ->(uid) { where(:uid => uid) }
end

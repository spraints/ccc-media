class DropboxUser < ActiveRecord::Base
  scope :for_uid, ->(uid) { where(:uid => uid) }
end

class DropboxFile < ActiveRecord::Base
  belongs_to :owner, class_name: "DropboxUser"
end

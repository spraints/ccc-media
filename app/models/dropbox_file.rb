class DropboxFile < ActiveRecord::Base
  belongs_to :owner, class_name: "DropboxUser"

  scope :in_category, ->(category) { where(:category => category) }
  scope :expired, -> { where("public_url_expires_at IS NULL OR public_url_expires_at < ?", Time.now) }

  def self.at_path(path)
    where(:path => path).first_or_initialize
  end
end

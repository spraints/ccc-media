class DropboxFile < ActiveRecord::Base
  belongs_to :owner, class_name: "DropboxUser"

  scope :for_list, -> { order("date desc").limit(20) }
  scope :in_category, ->(category) { where(:category => category) }
  scope :expired, -> { where("public_url_expires_at IS NULL OR public_url_expires_at < ?", Time.now) }

  def self.at_path(path)
    where(:path => path).first_or_initialize
  end

  def self.current
    where("date < ?", Date.today + 1).order("date DESC").first
  end
end

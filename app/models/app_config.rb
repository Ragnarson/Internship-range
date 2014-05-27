class AppConfig < ActiveRecord::Base
  self.primary_key = 'key'
  mount_uploader :club_logo, ImageUploader

  def club_name
     self[:club_name] || ''
  end
end

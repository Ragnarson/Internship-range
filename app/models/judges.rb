class Judges < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :function, presence: true
  validates :license_number, presence: true
end

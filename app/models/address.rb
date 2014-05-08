class Address < ActiveRecord::Base
  validates :city, presence: true
  validates :building, presence: true
  validates :zip_code, presence: true
  validates_associated :shooter

  belongs_to :shooter
end

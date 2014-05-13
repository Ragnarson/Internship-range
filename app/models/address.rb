class Address < ActiveRecord::Base
  validates :city, presence: true
  validates :building, presence: true
  validates :zip_code, presence: true
  validates_associated :shooter
  validates :shooter, presence: true
  belongs_to :shooter

  def is_first?
    self == shooter.addresses.first
  end
end

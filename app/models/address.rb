class Address < ActiveRecord::Base
  validates :city, presence: true
  validates :building, presence: true
  validates :zip_code, presence: true, format: { with: /\A\d{2}-\d{3}\z/ }
  validates :shooter, presence: true
  belongs_to :shooter

  def is_first?
    self == shooter.addresses.first
  end
end

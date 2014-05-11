class Shooter < ActiveRecord::Base
  has_many :payments
  has_many :contests, through: :shot_lists
  has_many :competitions, through: :shot_lists
  has_many :addresses, before_add: :validates_amount

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :pesel, presence: true,
    uniqueness: true, format: { with: /\A\d{11}\z/ }
  validates :joined_date, presence: true
  validate  :date_is_date?

  validates_each :addresses do |shooter, attr|
    if (shooter.addresses.count >= 2)
      shooter.errors.add(attr, "The user should have one or two addresses")
    end
  end

  attr_accessible :image
  mount_uploader :image, ImageUploader

  private
  def date_is_date?
    unless joined_date.is_a?(Date)
      errors.add(:joined_date, :not_a_date)
    end
  end
end

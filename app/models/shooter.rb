class Shooter < ActiveRecord::Base
  has_many :payments
  has_many :contests, through: :shot_lists
  has_many :competitions, through: :shot_lists
  has_many :addresses, before_add: :validates_amount

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :pesel, presence: true,
    uniqueness: true, format: { with: /\A\d{11}\z/ }
  validates :joined_date, presence: true
  validate  :date_is_date?
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates_each :addresses do |shooter, attr|
    if (shooter.addresses.count >= 2)
      shooter.errors.add(attr, "The user should have one or two addresses")
    end
  end

  mount_uploader :image, ImageUploader

  def full_name
    [first_name, last_name].join(' ') if first_name && last_name
  end

  private
  def date_is_date?
    unless joined_date.is_a?(Date)
      errors.add(:joined_date, :not_a_date)
    end
  end
end

class Shooter < ActiveRecord::Base
  attr_accessor :image

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save :update_weapon_list
  has_many :payments
  has_many :contests, through: :shot_lists
  has_many :competitions, through: :shot_lists
  has_many :addresses, ->{ order 'id'; limit 2 }, inverse_of: :shooter

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :pesel, presence: true,
    uniqueness: true, format: { with: /\A\d{11}\z/ }
  validates :addresses, length: { minimum: 1 }
  validates :joined_date, presence: true
  validate  :date_is_date?
  validate :prevent_destroying_single_address
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates_each :addresses do |shooter, attr|
    if (shooter.addresses.count >= 2)
      shooter.errors.add(attr, "The user should have one or two addresses")
    end
  end

  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :addresses, reject_if:
    lambda { |a| a[:city].blank? && a[:zip_code].blank? && a[:building].blank?}

  def full_name
    [first_name, last_name].join(' ') if first_name && last_name
  end

  def self.search(search)
    return where(nil) unless search
    where('first_name ILIKE ? OR last_name ILIKE ?', "%#{search.downcase}%", "%#{search.downcase}%")
  end

  private
  def date_is_date?
    unless joined_date.is_a?(Date)
      errors.add(:joined_date, :not_a_date)
    end
  end

  def update_weapon_list
    if(self.sport_permission == false)
      self.handgun = nil
      self.rifle = nil
      self.shotgun = nil
    end
  end

  def prevent_destroying_single_address
    remaining_addresses = addresses.reject(&:marked_for_destruction?)
    errors.add :addresses, "At least one address" if remaining_addresses.empty?
  end
end

class Shooter < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save :update_weapon_list
  has_many :payments
  has_many :contests, through: :shot_lists
  has_many :competitions, through: :shot_lists
  has_many :addresses, -> { order('id').limit(2) }, inverse_of: :shooter
  accepts_nested_attributes_for :addresses, reject_if: :all_blank, allow_destroy: :true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :pesel, presence: true,
    uniqueness: true, format: { with: /\A\d{11}\z/ }
  validates :joined_date, presence: true
  validate :date_is_date?
  validate :length_of_shooter_addesses
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  mount_uploader :image, ImageUploader
  scope :active, -> { where(active: true) }

  def full_name
    [first_name, last_name].join(' ') if first_name && last_name
  end

  def self.search(search)
    return where(nil) unless search
    where('first_name ILIKE ? OR last_name ILIKE ?',
     "%#{search.downcase}%", "%#{search.downcase}%")
  end

  private
  def date_is_date?
    return true if joined_date.is_a?(Date)
    errors.add(:joined_date, :not_a_date)
  end

  def update_weapon_list
    return nil unless sport_permission == false
    self.handgun = nil
    self.rifle = nil
    self.shotgun = nil
  end

  def length_of_shooter_addesses
    remaining_addresses = addresses.reject(&:marked_for_destruction?)
    errors.add :address,
     I18n.t('errors.messages.presence') if remaining_addresses.empty?
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ['ID', I18n.t('activerecord.attributes.shooter.first_name'),
        I18n.t('activerecord.attributes.shooter.last_name'),
        I18n.t('activerecord.attributes.shooter.date_of_birth'),
        I18n.t('activerecord.attributes.shooter.pesel'),
        I18n.t('activerecord.attributes.shooter.joined_date'),
        I18n.t('activerecord.attributes.shooter.email'),
        I18n.t('activerecord.attributes.shooter.phone'),
        I18n.t('activerecord.attributes.shooter.resolution_number'),
        I18n.t('activerecord.attributes.shooter.license_number'),
        I18n.t('activerecord.attributes.shooter.judge_license_number'),
        I18n.t('activerecord.attributes.shooter.sport_permission'),
        I18n.t('activerecord.attributes.shooter.handgun'),
        I18n.t('activerecord.attributes.shooter.rifle'),
        I18n.t('activerecord.attributes.shooter.shotgun'),
        I18n.t('activerecord.attributes.shooter.collectors_permission'),
        I18n.t('shooters.first_address'),
        I18n.t('shooters.second_address')]
      all.each do |shooter|
        if shooter.addresses.all[0]
          address1 = ApplicationController.helpers.
            display_address(shooter.addresses.all[0])
        end
        if shooter.addresses.all[1]
          address2 = ApplicationController.helpers.
            display_address(shooter.addresses.all[1])
        end
        csv << [*shooter.attributes.values_at(*["id", "first_name", "last_name",
          "date_of_birth", "pesel", "joined_date", "email", "phone",
          "resolution_number", "license_number", "judge_license_number",
          "sport_permission", "handgun", "rifle",
          "shotgun", "collectors_permission"]), address1, address2]
      end
    end
  end
end

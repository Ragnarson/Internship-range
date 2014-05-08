class Shooter < ActiveRecord::Base
  has_many :payments
  has_many :contests, through: :shot_lists
  has_many :competitions, through: :shot_lists

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :pesel, presence: true,
    uniqueness: true, format: { with: /^\d{11}$/ }
  validates :joined_date, presence: true
  validate  :date_is_date?
  validates :address_id, presence: true

  private
  def date_is_date?
    unless joined_date.is_a?(Date)
      errors.add(:joined_date, t(:not_a_date))
    end
  end
end

class Payment < ActiveRecord::Base
  belongs_to :shooter

  validates :description, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :shooter_id, presence: true
  validates :expiry_date, presence: true
  validate :date_is_date?

  def by
    [shooter.first_name, shooter.last_name].join(' ') if shooter.first_name && shooter.last_name
  end

  def expired?
    Date.today >= expiry_date - 7
  end

  private
  def date_is_date?
    errors.add(:date, :not_a_date) unless date.is_a?(Date)
    errors.add(:expiry_date, :not_a_date) unless expiry_date.is_a?(Date)
  end
end

class Payment < ActiveRecord::Base
  belongs_to :shooter

  validates :description, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :shooter_id, presence: true
  validate :date_is_date?

  def by
    [shooter.first_name, shooter.last_name].join(' ') if shooter.first_name && shooter.last_name
  end

  private
  def date_is_date?
    unless date.is_a?(Date)
      errors.add(:date, 'must be a valid date')
    end
  end
end

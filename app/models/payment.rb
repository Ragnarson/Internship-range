class Payment < ActiveRecord::Base
  belongs_to :shooter

  validates :description, presence: true
  validates :amount, presence: true
  validates :shooter_id, presence: true
  validate :date_is_date?

  def by
    [shooter.first_name, shooter.last_name].join(' ')
  end

  private
  def date_is_date?
    unless date.is_a?(Date)
      errors.add(:date, 'must be a valid date')
    end
  end
end

class Contest < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validate :date_is_date?

  private

  def date_is_date?
    unless date.is_a?(Date)
      errors.add(:date, 'must be a valid date')
    end
  end
end

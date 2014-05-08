class Contest < ActiveRecord::Base
  has_many :competitions
 
  validates :name, presence: true, uniqueness: true
  validate :date_is_date?

  private

  def date_is_date?
    unless date.is_a?(Date)
      errors.add(:date, :not_a_date)
    end
  end
end

class Competitor < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validate  :date_is_date?
  validates :club, presence: true

  private
  def date_is_date?
    unless date_of_birth.is_a?(Date)
      errors.add(:date_of_birth, t(:not_a_date))
    end
  end
end

class Competitor < ActiveRecord::Base
  belongs_to :contest
  has_and_belongs_to_many :competitions

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validate  :date_is_date?
  validates :club, presence: true

  private
  def date_is_date?
    unless date_of_birth.is_a?(Date)
      errors.add(:date_of_birth, :not_a_date)
    end
  end
end

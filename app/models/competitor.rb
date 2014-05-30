class Competitor < ActiveRecord::Base
  belongs_to :contest
  has_many :competitions, through: :shootings
  has_many :shootings, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validate  :date_is_date?
  validates :club, presence: true

  def display_shots(competition)
    set_target(id, competition.id).join(", ")
  end

  def display_sum(competition)
    set_target(id, competition.id).map { |x| x.capitalize == 'X' ? 10 : x.to_i }.
      compact.reduce(:+)
  end

  def count_max(competition)
    set_target(id, competition.id).map(&:capitalize).count('X')
  end

  private
  def set_target(competitor_id, competition_id)
    Shooting.where(competition_id: competition_id,
      competitor_id: competitor_id).map(&:target).flatten
  end

  def date_is_date?
    unless date_of_birth.is_a?(Date)
      errors.add(:date_of_birth, :not_a_date)
    end
  end
end

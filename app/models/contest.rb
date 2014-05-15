class Contest < ActiveRecord::Base
  has_many :competitions
  has_many :competitors, dependent: :destroy

  accepts_nested_attributes_for :competitors, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validate :date_is_date?

  private

  def date_is_date?
    unless date.is_a?(Date)
      errors.add(:date, :not_a_date)
    end
  end
end

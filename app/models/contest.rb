class Contest < ActiveRecord::Base
  has_many :competitions, dependent: :destroy
  has_many :competitors, dependent: :destroy
  has_many :judgements, dependent: :destroy
  has_many :judges, through: :judgements, dependent: :destroy

  accepts_nested_attributes_for :competitors, allow_destroy: true
  accepts_nested_attributes_for :judges, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates_associated :competitors
  validate :date_is_date?

  private
  def date_is_date?
    unless date.is_a?(Date)
      errors.add(:date, :not_a_date)
    end
  end

  def self.search(search)
    return where(nil) unless search
    where('name ILIKE ?', "%#{search.downcase}%")
  end
end

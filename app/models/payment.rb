class Payment < ActiveRecord::Base
  belongs_to :shooter

  validates :description, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :shooter_id, presence: true
  validate :date_is_date?

  def by
    [shooter.first_name, shooter.last_name].
      join(' ') if shooter.first_name && shooter.last_name
  end

  private
  def date_is_date?
    errors.add(:date, :not_a_date) unless date.is_a?(Date)
  end

  def self.search(search)
    return where(nil) unless search
    joins(:shooter).
      where('description ILIKE ? OR first_name ILIKE ? OR last_name ILIKE ?',
      "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%")
  end

  def self.limit_amount(amount_min, amount_max)
    return where(
      'amount >= ? AND amount <= ?',
      "#{amount_min.to_f}",
      "#{amount_max.to_f}"
    ) if amount_min.present? && amount_max.present?
    return where('amount >= ?', "#{amount_min.to_f}") if amount_min.present?
    return where('amount <= ?', "#{amount_max.to_f}") if amount_max.present?
    where(nil)
  end

  def self.limit_date(date_min, date_max)
    date_min = Date.parse('1800-01-01') unless date_min.present?
    date_max = Date.parse('2200-01-01') unless date_max.present?
    where('date >= ? AND date <= ?', "#{date_min}", "#{date_max}")
  end
end

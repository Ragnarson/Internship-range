class ShotList < ActiveRecord::Base
  serialize :shots, Array

  validates :contest_id, presence: true
  validates :shooter_id, presence: true
  validates :competition_id, presence: true

  belongs_to :contest
  belongs_to :shooter
  belongs_to :competition
end

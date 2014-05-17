class Competition < ActiveRecord::Base
  belongs_to :contest
  has_and_belongs_to_many :competitors

  validates :name, presence: true
  validates :classification, presence: true
  validates :number_of_shots, presence: true
end

class Competition < ActiveRecord::Base
  belongs_to :contest
  has_many :competitors, through: :shootings
  has_many :shootings, dependent: :destroy

  accepts_nested_attributes_for :shootings, allow_destroy: true

  validates :name, presence: true
  validates :classification, presence: true
  validates :number_of_shots, presence: true
end

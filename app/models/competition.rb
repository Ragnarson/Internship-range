class Competition < ActiveRecord::Base
  validates :name, presence: true
  validates :classification, presence: true
  validates :number_of_shots, presence: true
end

class Judges < ActiveRecord::Base
  has_many :judgements
  has_many :contest, through: :judgements

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :function, presence: true
  validates :license_number, presence: true
end

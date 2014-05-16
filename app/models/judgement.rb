class Judgement < ActiveRecord::Base
  belongs_to :contest
  belongs_to :judge
end

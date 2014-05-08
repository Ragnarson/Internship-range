class Competition < ActiveRecord::Base
  validates :name, presence: true
  validates :type, presence: true

	def new
		@competition = Competition.new
	end
end

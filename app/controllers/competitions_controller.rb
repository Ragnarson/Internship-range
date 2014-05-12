class CompetitionsController < ApplicationController
  before_filter :set_contest

  def new
    @competition = @contest.competitions.new
  end

  private
  def set_contest
    @contest = Contest.find(params[:contest_id])
  end
end

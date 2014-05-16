class CompetitionsController < ApplicationController
  before_action :contest

  def show
    @competition = @contest.competitions.find(params[:id])
  end

  def new
    @competition = @contest.competitions.build
  end

  def create
    @competition = @contest.competitions.new(competition_params)
    if @competition.save
      redirect_to [@contest, @competition],
        notice: t('flash.success.create',
          model: t('flash.competition'))
    else
      render action: 'new'
    end
  end

  def edit
    @competition = @contest.competitions.find(params[:id])
  end

  def update
    @competition = Competition.find(params[:id])
    if @competition.update(competition_params)
      redirect_to @competition,
        notice: t('flash.success_edit',
          model: t('flash.competition'))
    else
      render action: 'edit'
    end
  end

  def destroy
    Competition.find(params[:id]).destroy
    redirect_to competitions_url,
      notice: t('flash.success_destroy',
        model: t('flash.competition'))
  end

  private
  def competition_params
    params.require(:competition).permit(:name, 
      :classification, :number_of_shots, competitor_ids: [])
  end

  def contest
    @contest = Contest.find(params[:contest_id])
  end
end

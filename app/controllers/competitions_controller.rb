class CompetitionsController < ApplicationController
  before_action :contest
  after_action :disable_garbage_collector, only: :edit

  def show
    @competition = @contest.competitions.find(params[:id])
  end

  def create
    @competition = @contest.competitions.new(competition_params)
    if @competition.save
      redirect_to contest_url(@contest),
        notice: t('flash.success_create',
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
      redirect_to contest_url(@contest),
        notice: t('flash.success_edit',
          model: t('flash.competition'))
    else
      render action: 'edit'
    end
  end

  def destroy
    Competition.find(params[:id]).destroy
    redirect_to contest_url(@contest),
      notice: t('flash.success_destroy',
        model: t('flash.competition'))
  end

  def rate
    @competition = @contest.competitions.find(params[:id])
  end

  private
  def competition_params
    params.require(:competition).permit!
  end

  def contest
    @contest = Contest.find(params[:contest_id])
  end

  def disable_garbage_collector
    GC.disable
  end
end

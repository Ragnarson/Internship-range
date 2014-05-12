class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy]

  def index
    @contests = Contest.page(params[:page])
  end

  def show
  end

  def new
    @contest = Contest.new
  end

  def edit
  end

  def create
    @contest = Contest.new(contest_params)
    if @contest.save
      redirect_to @contest, notice: t('flash.success_create', model: t('activerecord.models.contest'))
    else
      render action: 'new'
    end
  end

  def update
    if @contest.update(contest_params)
      redirect_to @contest, notice: t('flash.success_edit', model: t('activerecord.models.contest'))
    else
      render action: 'edit'
    end
  end

  def destroy
    @contest.destroy
    redirect_to contests_url
  end

  private
  def set_contest
    @contest = Contest.find(params[:id])
  end

  def contest_params
    params.require(:contest).permit(:name, :date)
  end
end

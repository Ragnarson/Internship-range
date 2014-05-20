class ContestsController < ApplicationController
  before_action :authorize
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
      redirect_to contests_path,
        notice: t('flash.success_create', model: t('flash.contest'))
    else
      render action: 'new'
    end
  end

  def update
    if @contest.update(contest_params)
      redirect_to @contest,
        notice: t('flash.success_edit', model: t('flash.contest'))
    else
      render action: 'edit'
    end
  end

  def destroy
    @contest.destroy
    redirect_to contests_url,
      notice: t('flash.success_destroy', model: t('flash.contest'))
  end

  private
  def set_contest
    @contest = Contest.find(params[:id])
  end

  def contest_params
    params.require(:contest).permit(:name, :date,
      competitors_attributes: [:id, :first_name, :last_name,
      :date_of_birth, :club, :pk, competition_ids: []],
      judges_attributes: [:id, :first_name, :last_name,
      :function, :license_number, :_destroy]
    )
  end
end

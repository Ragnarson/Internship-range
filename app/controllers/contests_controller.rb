class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy, :select]
  before_action :contest_is_archived?, only: [:edit, :update, :destroy, :select]
  helper_method :sort_direction, :sort_column

  def index
    @contests = Contest.where("date >= ?", Date.today).search(params[:search]).
      order(sort_column + " " + sort_direction).page(params[:page])
  end

  def index_archive
    @contests = Contest.where("date < ?", Date.today).search(params[:search]).
      order(sort_column + " " + sort_direction).page(params[:page])
  end

  def show
    @competition = Competition.new
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

  def select
  end

  private
  def set_contest
    @contest = Contest.find(params[:id])
  end

  def sort_column
    Contest.column_names.include?(params[:sort]) ? params[:sort] : "date"
  end

  def sort_direction
    ["asc", "desc"].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def contest_params
    params.require(:contest).permit(:name, :date,
      competitors_attributes: [:id, :first_name, :last_name,
      :date_of_birth, :club, :_destroy, :pk, competition_ids: []],
      judges_attributes: [:id, :first_name, :last_name,
      :function, :license_number, :_destroy]
    )
  end
end

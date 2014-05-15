class ShootersController < ApplicationController
  before_action :set_shooter, only: [:show, :edit, :destroy]
  helper_method :sort_direction, :sort_column

  def index
    @shooters = Shooter.page(params[:page]).order(sort_column + " " + sort_direction)
  end

  def show
  end

  def new
    @shooter = Shooter.new
  end

  def create
  end

  def edit
  end

  def names
    shooters = Shooter.select('first_name, last_name, id').order(:last_name)
    render json: shooters.map { |x| {id: x.id, full_name: x.full_name} }
  end

  def destroy
    @shooter.destroy
    redirect_to shooters_url,
      notice: I18n.t(
        'flash.success_destroy',
        model: I18n.t('activerecord.models.shooter'))
  end

  private
  def set_shooter
    @shooter = Shooter.find(params[:id])
  end

  def sort_column
    Shooter.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    ["asc", "desc"].include?(params[:direction]) ? params[:direction] : "asc"
  end
end

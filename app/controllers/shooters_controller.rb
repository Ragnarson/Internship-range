class ShootersController < ApplicationController
  before_action :set_shooter, only: [:show, :edit]
  def new
    @shooter = Shooter.new
  end

  def edit
  end

  def index
    @shooters = Shooter.page(params[:page])
  end

  def show
  end

  def names
    shooters = Shooter.select('first_name, last_name, id').order(:last_name)
    render json: shooters.map { |x| {id: x.id, full_name: x.full_name} }
  end

  private
  def set_shooter
    @shooter = Shooter.find(params[:id])
  end
end

class ShootersController < ApplicationController
  before_action :shooter, only: [:show, :edit, :destroy, :update]
  helper_method :sort_direction, :sort_column

  def index
    @shooters = Shooter.active.search(params[:search])
      .order(sort_column + ' ' + sort_direction).page(params[:page])
    respond_to do |format|
      format.html
      format.csv { render text: @shooters.to_csv }
    end
  end

  def show
  end

  def new
    @shooter = Shooter.new
    build_addresses_for_shooter(@shooter)
  end

  def create
    @shooter = Shooter.new(permitted_shooter)
    if @shooter.save
      redirect_to(
        @shooter,
        notice: I18n.t('flash.success_create', model: I18n.t('flash.shooter'))
      )
    else
      build_addresses_for_shooter(@shooter)
      render(:new, :@shooter => @shooter)
    end
  end

  def edit
    build_addresses_for_shooter(@shooter)
  end

  def names
    shooters = Shooter.active.select('first_name, last_name, id').order(:last_name)
    render json: shooters.map { |x| {id: x.id, full_name: x.full_name} }
  end

  def update
    if @shooter.update_attributes(permitted_shooter)
      redirect_to(
        @shooter,
        notice: I18n.t('flash.success_edit', model: I18n.t('flash.shooter'))
      )
    else
      build_addresses_for_shooter(@shooter)
      render(:edit)
    end
  end

  def destroy
    @shooter.update_attribute(:active, false)
    redirect_to(
      shooters_url,
      notice: I18n.t('flash.success_destroy', model: I18n.t('flash.shooter'))
    )
  end

  private
  def shooter
    @shooter = Shooter.find(params[:id])
  end

  def sort_column
    Shooter.column_names.include?(params[:sort]) ? params[:sort] : 'last_name'
  end

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def permitted_shooter
    params.require(:shooter).permit(:first_name, :last_name, :pesel, :phone,
    :email, :resolution_number, :license_number, :judge_license_number,
    :sport_permission, :joined_date, :date_of_birth, :handgun, :rifle,
    :shotgun, :collectors_permission, addresses_attributes:
    [:id, :shooter_id, :city, :building, :flat, :zip_code, :street])
  end

  def build_addresses_for_shooter(shooter)
    (2 - shooter.addresses.length).times { shooter.addresses.build }
  end
end

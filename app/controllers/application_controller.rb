class ApplicationController < ActionController::Base
  before_filter :authorize
  before_action :enable_garbage_collector
  force_ssl unless Rails.env.development?
  helper_method :current_user, :signed_in?
  protect_from_forgery with: :exception
  before_action :app_configs_set

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    if current_user.nil?
      flash[:alert] = t('flash.not_authorized')
      redirect_to signin_path
    end
  end

  def signed_in?
    session[:user_id].present?
  end

  def enable_garbage_collector
    GC.enable
  end

  def app_configs_set
    @app_config ||= AppConfig.where(key: 'app_config').first_or_create
  end

  protected
  def store_controller
    session[:return_to] = Rails.application.
      routes.recognize_path(request.env['PATH_INFO'])[:controller]
  end

  def get_previous_controller
    controller = session[:return_to]
    session[:return_to] = nil
    controller
  end

  def contest_is_archived?
    if @contest.date < Date.today
      redirect_to :back
      flash[:notice] = t('activerecord.errors.models.contest.present_in_archive')
    end
  end
end

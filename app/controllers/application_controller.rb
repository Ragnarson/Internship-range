class ApplicationController < ActionController::Base
  force_ssl unless Rails.env.development?
  helper_method :current_user
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    if current_user.nil?
      flash[:alert] = t('flash.not_authorized')
      redirect_to root_path
    end
  end
end

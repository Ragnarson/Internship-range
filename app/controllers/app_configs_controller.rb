class AppConfigsController < ApplicationController
  def update
    if @app_config.update(app_config_params)
      redirect_to root_path,
        notice: I18n.t(
          'flash.success_edit',
           model: I18n.t('activerecord.models.app_config'))
    else
      flash[:notice] = I18n.t('flash.error_settings_set')
      render 'index'
    end
  end

  private
  def app_config_params
    params.require(:app_config).permit(:club_name, :club_logo)
  end
end

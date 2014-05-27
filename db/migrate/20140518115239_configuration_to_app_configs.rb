class ConfigurationToAppConfigs < ActiveRecord::Migration
  def change
    rename_table :configurations, :app_configs
  end
end

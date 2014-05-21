class AppConfigColumnRename < ActiveRecord::Migration
  def change
    drop_table :app_configs
  end
end

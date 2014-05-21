class SettingPrimaryKey < ActiveRecord::Migration
  def change
    execute "ALTER TABLE app_configs ADD PRIMARY KEY (key);"
  end
end

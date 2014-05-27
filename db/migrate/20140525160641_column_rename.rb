class ColumnRename < ActiveRecord::Migration
  def change
    rename_column :app_configs, :value, :club_name
    rename_column :app_configs, :image, :club_logo
  end
end

class AddImageColumnToAppConfig < ActiveRecord::Migration
  def change
    add_column :app_configs, :image, :string
  end
end

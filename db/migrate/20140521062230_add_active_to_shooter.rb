class AddActiveToShooter < ActiveRecord::Migration
  def change
    add_column :shooters, :active, :boolean, default: true
  end
end

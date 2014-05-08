class ChangeShooterToCompetitor < ActiveRecord::Migration
  def change
    rename_column :shot_lists, :shooter_id, :competitor_id
  end
end

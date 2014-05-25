class DropCompetitionCompetitors < ActiveRecord::Migration
  def change
    drop_table :competitions_competitors
    drop_table :shot_lists
  end
end

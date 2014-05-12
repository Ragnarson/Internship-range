class AddContestIdToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :contest_id, :integer
  end
end

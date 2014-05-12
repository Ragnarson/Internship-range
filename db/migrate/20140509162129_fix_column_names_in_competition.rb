class FixColumnNamesInCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :number_of_shots, :integer
    rename_column :competitions, :type, :classification
  end
end

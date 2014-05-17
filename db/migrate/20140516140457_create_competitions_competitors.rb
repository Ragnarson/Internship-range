class CreateCompetitionsCompetitors < ActiveRecord::Migration
  def change
    create_table :competitions_competitors do |t|
      t.belongs_to :competition
      t.belongs_to :competitor
    end
  end
end

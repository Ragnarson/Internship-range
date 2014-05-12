class CreateCompetitors < ActiveRecord::Migration
  def change
    create_table :competitors do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :club
      t.boolean :pk

      t.timestamps
    end
  end
end

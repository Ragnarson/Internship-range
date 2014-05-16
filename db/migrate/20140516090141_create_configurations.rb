class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :club_logo
      t.string :club_name

      t.timestamps
    end
  end
end

class CreateShotLists < ActiveRecord::Migration
  def change
    create_table :shot_lists do |t|
      t.text :shots

      t.timestamps
    end
  end
end

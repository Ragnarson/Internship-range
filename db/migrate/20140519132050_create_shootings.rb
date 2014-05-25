class CreateShootings < ActiveRecord::Migration
  def change
    create_table :shootings do |t|
      t.references :competitor, index: true
      t.references :competition, index: true
      t.text :target

      t.timestamps
    end
  end
end

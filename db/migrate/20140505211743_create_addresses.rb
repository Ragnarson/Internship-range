class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :building
      t.integer :flat
      t.integer :shooter_id
      t.string :zip_code

      t.timestamps
    end
  end
end
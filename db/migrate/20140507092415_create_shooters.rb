class CreateShooters < ActiveRecord::Migration
  def change
    create_table :shooters do |t|
      t.string :first_name
      t.string :last_name
      t.string :pesel
      t.string :phone
      t.string :email
      t.date :joined_date
      t.string :resolution_number
      t.string :license_number
      t.boolean :sport_permission
      t.boolean :handgun
      t.boolean :rifle
      t.boolean :shotgun
      t.boolean :collectors_permission
      t.integer :address_id
      t.integer :second_address_id
      t.string :image

      t.timestamps
    end
  end
end

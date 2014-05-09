class AddDateOfBirthToShooter < ActiveRecord::Migration
  def change
    add_column :shooters, :date_of_birth, :date
  end
end

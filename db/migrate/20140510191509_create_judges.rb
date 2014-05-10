class CreateJudges < ActiveRecord::Migration
  def change
    create_table :judges do |t|
      t.string :first_name
      t.string :last_name
      t.string :function
      t.string :license_number 
      t.timestamps
    end
  end
end

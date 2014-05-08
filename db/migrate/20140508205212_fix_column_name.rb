class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :payments, :user_id, :shooter_id
  end
end

class AddArchivedToContests < ActiveRecord::Migration
  def change
    add_column :contests, :active, :boolean, default: true
  end
end

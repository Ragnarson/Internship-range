class AddReferencesToShotList < ActiveRecord::Migration
  def change
    add_reference :shot_lists, :contest, index: true
    add_reference :shot_lists, :shooter, index: true
    add_reference :shot_lists, :competition, index: true
  end
end

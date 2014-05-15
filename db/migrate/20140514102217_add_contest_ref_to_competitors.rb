class AddContestRefToCompetitors < ActiveRecord::Migration
  def change
    add_reference :competitors, :contest, index: true
  end
end

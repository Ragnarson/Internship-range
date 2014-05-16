class CreateJudgements < ActiveRecord::Migration
  def change
    create_table :judgements do |t|

      t.timestamps
    end
  end
end

class AddRelationJudgeContest < ActiveRecord::Migration
  def change
    add_column :judgements, :contest_id, :integer
    add_column :judgements, :judge_id, :integer
  end
end

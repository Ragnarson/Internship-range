class AddJudgeLicenseNumberToShooter < ActiveRecord::Migration
  def change
    add_column :shooters, :judge_license_number, :string
  end
end

class RemoveExpiryDateFromPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :expiry_date, :date
  end
end

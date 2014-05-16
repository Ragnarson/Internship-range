class AddExpiryDateToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :expiry_date, :date
  end
end

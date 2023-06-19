class ChangeExpiryInPayment < ActiveRecord::Migration[7.0]
  def change
    remove_column :payment_histories, :expiry
    add_column :payment_histories, :expiry, :date
  end
end

class ChangePaymentHistory < ActiveRecord::Migration[7.0]
  def change
    remove_column :payment_histories, :paymentmethod
    add_column :payment_histories, :cardnumber, :string
    add_column :payment_histories, :expiry, :string
    add_column :payment_histories, :cvc, :string
    add_column :payment_histories, :amount, :integer

  end
end
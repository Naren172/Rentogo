class DropPaymentHistory < ActiveRecord::Migration[7.0]
  def change
    drop_table :payment_histories
  end
end

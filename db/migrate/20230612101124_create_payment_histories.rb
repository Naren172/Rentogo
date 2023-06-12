class CreatePaymentHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_histories do |t|
      t.string :paymentmethod
      t.references :rental_history , null: false , foreign_key: true

      t.timestamps
    end
  end
end

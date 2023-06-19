class RemoveAssociationFromPayment < ActiveRecord::Migration[7.0]
  def change
    remove_reference :payment_histories, :rental_history
  end
end

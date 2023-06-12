class AddDateToRentalHistory < ActiveRecord::Migration[7.0]
  def change
    add_column :rental_histories, :date, :string
  end
end

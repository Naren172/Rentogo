class RemoveDateFromRentalHistory < ActiveRecord::Migration[7.0]
  def change
    remove_column :rental_histories, :date
  end
end

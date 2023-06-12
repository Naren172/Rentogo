class CreateRentalHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :rental_histories do |t|
      t.references :product , null: false , foreign_key: true
      t.references :renter, null: false , foreign_key: true
      t.references :user, null: false , foreign_key: true
      t.timestamps
    end
  end
end

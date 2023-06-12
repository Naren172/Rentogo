class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string :location
      t.references :payment_history , null: false , foreign_key: true
      t.references :rental_history , null: false , foreign_key: true

      t.timestamps
    end
  end
end

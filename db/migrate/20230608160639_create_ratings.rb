class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.string :comment
      t.references :ratable, polymorphic: true, null: false
      t.timestamps
    end
  end
end

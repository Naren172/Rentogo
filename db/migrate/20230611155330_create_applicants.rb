class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants do |t|
      t.string :status
      t.references :product , null: false , foreign_key: true
      t.timestamps
    end
  end
end

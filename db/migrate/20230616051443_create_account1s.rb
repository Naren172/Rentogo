class CreateAccount1s < ActiveRecord::Migration[7.0]
  def change
    create_table :account1s do |t|
      t.string :name,:email
      t.references :accountable ,polymorphic: true
      t.timestamps
    end
  end
end

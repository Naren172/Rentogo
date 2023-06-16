class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
   create_table :accounts do |t|
      t.string :name,:email
      t.references :accountable ,polymorphic: true
      t.timestamps
    end
    

    remove_column :renters,:name
    remove_column :renters,:email
    remove_column :renters,:password_digest

    remove_column :users,:name
    remove_column :users,:email 
    remove_column :users,:password_digest
    
  end
end

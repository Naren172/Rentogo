class AddFieldFromUser < ActiveRecord::Migration[7.0]
  def change
     add_column :users, :email, :string
    add_column :renters, :email, :string
  end
end

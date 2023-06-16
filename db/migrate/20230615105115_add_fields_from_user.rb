class AddFieldsFromUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_digest, :string
    add_column :renters, :password_digest, :string
  end
end

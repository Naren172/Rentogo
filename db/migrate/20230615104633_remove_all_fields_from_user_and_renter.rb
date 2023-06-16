class RemoveAllFieldsFromUserAndRenter < ActiveRecord::Migration[7.0]
  def change
    remove_column :renters, :encrypted_password
    remove_column :renters, :reset_password_token
    remove_column :renters, :reset_password_sent_at
    remove_column :renters, :email
    remove_column :renters, :remember_created_at
  end
end

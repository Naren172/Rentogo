class DropPassword < ActiveRecord::Migration[7.0]
  def change
    remove_column :owners ,:password
    add_column :owners, :password_digest ,:string
  end
end

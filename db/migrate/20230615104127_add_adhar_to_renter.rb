class AddAdharToRenter < ActiveRecord::Migration[7.0]
  def change
    add_column :renters, :aadhar, :integer
  end
end

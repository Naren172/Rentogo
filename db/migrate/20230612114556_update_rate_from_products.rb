class UpdateRateFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :rent
    add_column :products, :rent, :integer
  end
end
:rent, :integer
end
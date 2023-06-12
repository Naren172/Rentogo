class Drop < ActiveRecord::Migration[7.0]
  def change
    drop_table :owners
    drop_table :owner1s
  end
end

class RemoveRenterId < ActiveRecord::Migration[7.0]
  def change
   remove_column :rental_histories, :user_id
    
  end
end

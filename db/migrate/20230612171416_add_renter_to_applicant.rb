class AddRenterToApplicant < ActiveRecord::Migration[7.0]
  def change
    remove_column :applicants, :renter_id
    add_column :applicants, :renter_id, :bigint
  end
end

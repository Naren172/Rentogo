class AddRenterToApplicants < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :renter_id, :integer
  end
end

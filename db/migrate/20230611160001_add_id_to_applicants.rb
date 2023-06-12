class AddIdToApplicants < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :user_id, :integer
  end
end

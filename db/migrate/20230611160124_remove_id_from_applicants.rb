class RemoveIdFromApplicants < ActiveRecord::Migration[7.0]
  def change
    remove_column :applicants, :user_id
  end
end

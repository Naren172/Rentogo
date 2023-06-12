class AddIdToRating < ActiveRecord::Migration[7.0]
  def change
    add_column :ratings, :from_id, :integer
  end
end

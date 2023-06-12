class Product < ApplicationRecord
  belongs_to :user
  has_many :applicants
  has_many :rental_histories
  has_one_attached :image
  has_many :ratings, as: :ratable
  def unavailable?
    status=='Unavailable'
  end
end

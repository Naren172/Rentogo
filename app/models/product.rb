class Product < ApplicationRecord
  belongs_to :user
  has_many :applicants, dependent: :destroy
  has_many :rental_histories, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :ratings, as: :ratable, dependent: :destroy
  def unavailable?
    status=='Unavailable'
  end

  validates :name, presence: true, length: { minimum: 5 }
  validates :rent, presence: true


  scope :available_products , -> { Product.where("status = ?" , "Available")}
  scope :unavailable_products , -> { Product.where("status = ?" , "Unavailable")}

end

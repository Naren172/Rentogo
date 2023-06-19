class Product < ApplicationRecord
  belongs_to :user
  has_many :applicants, dependent: :destroy
  has_many :rental_histories, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :ratings, as: :ratable, dependent: :destroy
  def unavailable?
    status=='Unavailable'
  end

 


  scope :available_products , -> { Product.where("status = ?" , "Available")}
  scope :unavailable_products , -> { Product.where("status = ?" , "Unavailable")}

  validates :name, length: { in: 3..30 }
  validates :description, length: {minimum:10,maximum:1500,:too_short=>"is too short",:too_long=>"is too long"}


end

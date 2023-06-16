class Renter < ApplicationRecord
    has_one :account, as: :accountable, dependent: :destroy
    has_many :rental_histories, dependent: :destroy
    has_many :ratings, as: :ratable, dependent: :destroy
    has_many :products, through: :rental_histories
end

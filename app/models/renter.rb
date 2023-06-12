class Renter < ApplicationRecord
    has_many :rental_histories, dependent: :destroy
    has_many :ratings, as: :ratable, dependent: :destroy
    has_secure_password
end

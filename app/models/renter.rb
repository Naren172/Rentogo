class Renter < ApplicationRecord
    has_many :rental_histories
    has_many :ratings, as: :ratable
    has_secure_password
end

class User < ApplicationRecord
    has_many :products, dependent: :destroy
    has_many :rental_histories, through: :products
    has_secure_password
end

